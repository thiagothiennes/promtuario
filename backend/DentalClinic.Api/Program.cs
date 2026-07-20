using System.Text;
using DentalClinic.Core.Application.Interfaces;
using DentalClinic.Core.Application.Services;
using DentalClinic.Core.Domain.Repositories;
using DentalClinic.Infrastructure.Persistence;
using DentalClinic.Infrastructure.Persistence.Repositories;
using DentalClinic.Infrastructure.Security;
using DentalClinic.Infrastructure.Storage;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using DentalClinic.Api.Middlewares;
using DentalClinic.Api.Filters;
using DentalClinic.Api.Hubs;

var builder = WebApplication.CreateBuilder(args);

// 1. Configuração do Banco de Dados (PostgreSQL)
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseNpgsql(builder.Configuration.GetConnectionString("DefaultConnection")));

// 2. Injeção de Dependência (DI) - Repositories
builder.Services.AddScoped<IUserRepository, UserRepository>();
builder.Services.AddScoped<IPatientRepository, PatientRepository>();
builder.Services.AddScoped<IAppointmentRepository, AppointmentRepository>();
builder.Services.AddScoped<IProntuarioRepository, ProntuarioRepository>();
builder.Services.AddScoped<ITreatmentPlanRepository, TreatmentPlanRepository>();
builder.Services.AddScoped<IUserSessionRepository, UserSessionRepository>();
builder.Services.AddScoped<IReportRepository, ReportRepository>();
builder.Services.AddScoped<IWaitListRepository, WaitListRepository>();
builder.Services.AddScoped<INotificationRepository, NotificationRepository>();
builder.Services.AddScoped<IAnexoRepository, AnexoRepository>();

// 2.1. Injeção de Dependências (DI) - Services
builder.Services.AddScoped<IPasswordHasher, PasswordHasher>();
builder.Services.AddScoped<ITokenService, TokenService>();
builder.Services.AddScoped<IAuthService, AuthService>();
builder.Services.AddScoped<IAppointmentService, AppointmentService>();
builder.Services.AddScoped<IStorageService, LocalStorageService>();

// 3. SignalR para atualizações em tempo real
builder.Services.AddSignalR();

// 4. Filtros Globais
builder.Services.AddControllers(options =>
{
    options.Filters.Add<AuditFilter>(); // LGPD Audit Filter
});

// 5. Configuração de Autenticação JWT
var jwtSettings = builder.Configuration.GetSection("Jwt");
var key = Encoding.ASCII.GetBytes(jwtSettings["Key"]!);

builder.Services.AddAuthentication(x =>
{
    x.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    x.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
})
.AddJwtBearer(x =>
{
    x.RequireHttpsMetadata = false;
    x.SaveToken = true;
    x.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuerSigningKey = true,
        IssuerSigningKey = new SymmetricSecurityKey(key),
        ValidateIssuer = true,
        ValidIssuer = jwtSettings["Issuer"],
        ValidateAudience = true,
        ValidAudience = jwtSettings["Audience"],
        ValidateLifetime = true,
        ClockSkew = TimeSpan.Zero
    };
});

// 6. Configuração de CORS para o Flutter
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowFlutter",
        policy => policy.WithOrigins("http://localhost:3000", "http://localhost:5173", "http://localhost:8080")
                        .AllowAnyMethod()
                        .AllowAnyHeader()
                        .AllowCredentials()); // Necessário para SignalR
});

builder.Services.AddEndpointsApiExplorer();

// 7. Configuração do Swagger com suporte a JWT
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new OpenApiInfo { Title = "OdontoClinica API", Version = "v1" });
    c.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        Description = "JWT Authorization header using the Bearer scheme. Example: \"Authorization: Bearer {token}\"",
        Name = "Authorization",
        In = ParameterLocation.Header,
        Type = SecuritySchemeType.ApiKey,
        Scheme = "Bearer"
    });
    c.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference { Type = ReferenceType.SecurityScheme, Id = "Bearer" }
            },
            Array.Empty<string>()
        }
    });
});

var app = builder.Build();

// 8. Middleware Pipeline
app.UseMiddleware<ExceptionMiddleware>();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseStaticFiles();
app.UseHttpsRedirection();
app.UseCors("AllowFlutter");

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

// Registro do Hub SignalR
app.MapHub<ClinicHub>("/hubs/clinic");

// 9. Migrações Automáticas
using (var scope = app.Services.CreateScope())
{
    var db = scope.ServiceProvider.GetRequiredService<ApplicationDbContext>();
    db.Database.Migrate();
}

app.Run();
