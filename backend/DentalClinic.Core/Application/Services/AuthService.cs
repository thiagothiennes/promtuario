using DentalClinic.Core.Application.DTOs;
using DentalClinic.Core.Application.Interfaces;
using DentalClinic.Core.Common;
using DentalClinic.Core.Domain.Entities;
using DentalClinic.Core.Domain.Repositories;
using Microsoft.Extensions.Logging;

namespace DentalClinic.Core.Application.Services;

/// <summary>
/// Implementação do serviço de autenticação.
/// Gerencia o ciclo de vida da sessão do usuário e segurança de acesso.
/// </summary>
public class AuthService : IAuthService
{
    private readonly IUserRepository _userRepository;
    private readonly IUserSessionRepository _sessionRepository;
    private readonly ITokenService _tokenService;
    private readonly IPasswordHasher _passwordHasher;
    private readonly ILogger<AuthService> _logger;

    public AuthService(
        IUserRepository userRepository,
        IUserSessionRepository sessionRepository,
        ITokenService tokenService,
        IPasswordHasher passwordHasher,
        ILogger<AuthService> logger)
    {
        _userRepository = userRepository;
        _sessionRepository = sessionRepository;
        _tokenService = tokenService;
        _passwordHasher = passwordHasher;
        _logger = logger;
    }

    public async Task<Result<TokenDto>> AuthenticateAsync(LoginDto loginDto)
    {
        _logger.LogInformation("Tentativa de login para o email: {Email}", loginDto.Email);

        var user = await _userRepository.GetByEmailAsync(loginDto.Email);

        if (user == null || !_passwordHasher.VerifyPassword(loginDto.Password, user.PasswordHash))
        {
            if (user != null)
            {
                user.IncrementFailedLogin();
                await _userRepository.UpdateAsync(user);
            }

            _logger.LogWarning("Falha na autenticação para o usuário: {Email}", loginDto.Email);
            return Result<TokenDto>.Failure("Credenciais inválidas.");
        }

        if (user.Status == 1) // Blocked
        {
            return Result<TokenDto>.Failure("Sua conta está bloqueada. Entre em contato com o administrador.");
        }

        // Gera os tokens
        var accessToken = _tokenService.GenerateAccessToken(user);
        var refreshToken = _tokenService.GenerateRefreshToken();

        // Persiste a sessão (Refresh Token)
        var session = UserSession.Create(user.Id, refreshToken, 7, "0.0.0.0"); // TODO: Obter IP do contexto
        await _sessionRepository.AddAsync(session);

        // Atualiza info de login
        user.UpdateLoginInfo();
        await _userRepository.UpdateAsync(user);

        var userDto = new UserDto(user.Id, user.Name, user.EmailAddress.Value, user.Role.ToString());

        return Result<TokenDto>.Ok(new TokenDto(accessToken, refreshToken, userDto));
    }

    public async Task<Result<TokenDto>> RefreshTokenAsync(RefreshTokenRequest request)
    {
        var session = await _sessionRepository.GetByTokenAsync(request.RefreshToken);

        if (session == null || !session.IsActive)
        {
            return Result<TokenDto>.Failure("Sessão inválida ou expirada.");
        }

        var user = await _userRepository.GetByIdAsync(session.UserId);
        if (user == null || user.Status != 0)
        {
            return Result<TokenDto>.Failure("Usuário não encontrado ou inativo.");
        }

        // Revoga a sessão atual
        session.Revoke();
        await _sessionRepository.UpdateAsync(session);

        // Gera novos tokens
        var newAccessToken = _tokenService.GenerateAccessToken(user);
        var newRefreshToken = _tokenService.GenerateRefreshToken();

        // Cria nova sessão
        var newSession = UserSession.Create(user.Id, newRefreshToken, 7, session.CreatedByIp);
        await _sessionRepository.AddAsync(newSession);

        var userDto = new UserDto(user.Id, user.Name, user.EmailAddress.Value, user.Role.ToString());

        return Result<TokenDto>.Ok(new TokenDto(newAccessToken, newRefreshToken, userDto));
    }

    public async Task RevokeTokenAsync(string userId)
    {
        if (Guid.TryParse(userId, out var userGuid))
        {
            await _sessionRepository.RevokeAllUserSessionsAsync(userGuid);
            _logger.LogInformation("Todas as sessões do usuário {UserId} foram revogadas.", userId);
        }
    }
}
