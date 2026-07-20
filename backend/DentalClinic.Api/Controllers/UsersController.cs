using DentalClinic.Core.Application.DTOs;
using DentalClinic.Core.Application.Interfaces;
using DentalClinic.Core.Domain.Entities;
using DentalClinic.Core.Domain.Repositories;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace DentalClinic.Api.Controllers;

/// <summary>
/// Controller para gestão de usuários (Colaboradores, Professores, Alunos).
/// Acesso restrito a Administradores e Coordenadores.
/// </summary>
[Authorize(Roles = "Admin,Coordinator")]
[ApiController]
[Route("api/[controller]")]
public class UsersController : ControllerBase
{
    private readonly IUserRepository _userRepository;
    private readonly IPasswordHasher _passwordHasher;
    private readonly ILogger<UsersController> _logger;

    public UsersController(
        IUserRepository userRepository,
        IPasswordHasher passwordHasher,
        ILogger<UsersController> logger)
    {
        _userRepository = userRepository;
        _passwordHasher = passwordHasher;
        _logger = logger;
    }

    /// <summary>
    /// Lista usuários com filtros reais de papel e busca textual.
    /// </summary>
    [HttpGet]
    public async Task<IActionResult> Get([FromQuery] string? role = null, [FromQuery] string? search = null)
    {
        UserRole? userRole = null;
        if (!string.IsNullOrEmpty(role) && Enum.TryParse<UserRole>(role, true, out var parsedRole))
        {
            userRole = parsedRole;
        }

        var users = await _userRepository.GetAllAsync(userRole, search);

        var userDtos = users.Select(u => new UserDto(
            u.Id,
            u.Name,
            u.EmailAddress.Value,
            u.Roles.FirstOrDefault().ToString() ?? "None"
        ));

        return Ok(userDtos);
    }

    /// <summary>
    /// Cadastra um novo usuário.
    /// </summary>
    [HttpPost]
    public async Task<IActionResult> Create([FromBody] CreateUserRequest request)
    {
        if (!Enum.TryParse<UserRole>(request.Role, true, out var role))
        {
            return BadRequest("Papel de usuário inválido.");
        }

        var user = DentalClinic.Core.Domain.Entities.User.Create(
            request.Name,
            request.Email,
            request.CPF,
            request.DateOfBirth,
            request.Phone,
            DentalClinic.Core.Domain.ValueObjects.Address.Create(
                request.Street,
                request.Number,
                request.Complement,
                request.Neighborhood,
                request.City,
                request.State,
                request.ZipCode),
            role
        );

        user.SetPasswordHash(_passwordHasher.HashPassword(request.Password));
        user.ConfirmEmail();

        await _userRepository.AddAsync(user);

        return CreatedAtAction(nameof(Get), new { id = user.Id }, new UserDto(user.Id, user.Name, user.EmailAddress.Value, user.Roles.First().ToString()));
    }

    /// <summary>
    /// Altera o status de ativação de um usuário.
    /// </summary>
    [HttpPatch("{id}/status")]
    public async Task<IActionResult> ToggleStatus(Guid id, [FromBody] ToggleStatusRequest request)
    {
        var user = await _userRepository.GetByIdAsync(id);
        if (user == null) return NotFound();

        if (request.Active) user.Activate();
        else user.Deactivate();

        await _userRepository.UpdateAsync(user);
        return NoContent();
    }
}

public record CreateUserRequest(
    string Name,
    string Email,
    string Password,
    string Role,
    string CPF,
    DateTime DateOfBirth,
    string Phone,
    string Street,
    string Number,
    string? Complement,
    string Neighborhood,
    string City,
    string State,
    string ZipCode
);

public record ToggleStatusRequest(bool Active);
