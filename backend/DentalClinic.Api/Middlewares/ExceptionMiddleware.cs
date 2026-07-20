using System.Net;
using System.Text.Json;
using DentalClinic.Core.Common;

namespace DentalClinic.Api.Middlewares;

/// <summary>
/// Middleware global para tratamento de exceções.
/// Garante que o sistema nunca retorne um stack trace para o cliente em produção (LGPD/Segurança).
/// </summary>
public class ExceptionMiddleware
{
    private readonly RequestDelegate _next;
    private readonly ILogger<ExceptionMiddleware> _logger;
    private readonly IHostEnvironment _env;

    public ExceptionMiddleware(RequestDelegate next, ILogger<ExceptionMiddleware> logger, IHostEnvironment env)
    {
        _next = next;
        _logger = logger;
        _env = env;
    }

    public async Task InvokeAsync(HttpContext context)
    {
        try
        {
            await _next(context);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Ocorreu uma exceção não tratada: {Message}", ex.Message);
            await HandleExceptionAsync(context, ex);
        }
    }

    private async Task HandleExceptionAsync(HttpContext context, Exception exception)
    {
        context.Response.ContentType = "application/json";
        context.Response.StatusCode = (int)HttpStatusCode.InternalServerError;

        if (_env.IsDevelopment())
        {
            var response = new { StatusCode = context.Response.StatusCode, Message = exception.Message, StackTrace = exception.StackTrace };
            var options = new JsonSerializerOptions { PropertyNamingPolicy = JsonNamingPolicy.CamelCase };
            var json = JsonSerializer.Serialize(response, options);
            await context.Response.WriteAsync(json);
        }
        else
        {
            var response = new { StatusCode = context.Response.StatusCode, Message = "Ocorreu um erro interno no servidor. Por favor, tente novamente mais tarde." };
            var options = new JsonSerializerOptions { PropertyNamingPolicy = JsonNamingPolicy.CamelCase };
            var json = JsonSerializer.Serialize(response, options);
            await context.Response.WriteAsync(json);
        }
    }
}
