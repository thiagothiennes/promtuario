# 📘 Guia Completo de Testagem - BACKEND (ASP.NET Core 9)

## 📋 Índice

1. [Visão Geral da Arquitetura](#visão-geral-da-arquitetura)
2. [Estrutura do Projeto](#estrutura-do-projeto)
3. [Configuração do Ambiente](#configuração-do-ambiente)
4. [Passo a Passo para Execução](#passo-a-passo-para-execução)
5. [Testes Unitários](#testes-unitários)
6. [Testes de Integração](#testes-de-integração)
7. [Testes Manuais via Swagger](#testes-manuais-via-swagger)
8. [Endpoints Detalhados](#endpoints-detalhados)
9. [SinalR - Tempo Real](#signalr---tempo-real)
10. [Segurança e LGPD](#segurança-e-lgpd)
11. [Troubleshooting](#troubleshooting)

---

## 🏗️ Visão Geral da Arquitetura

### **Padrões Utilizados**
- **DDD (Domain-Driven Design)**: Separação clara entre domínio, aplicação e infraestrutura
- **Repository Pattern**: Abstração do acesso a dados
- **Dependency Injection**: Injeção de dependências nativa do .NET
- **SOLID**: Princípios de design orientado a objetos
- **CQRS (parcial)**: Separação de comandos e consultas nos serviços

### **Camadas**
```
┌─────────────────────────────────────────┐
│         DentalClinic.Api                │  ← Controllers, Middleware, Hubs
│         (Apresentação)                  │
├─────────────────────────────────────────┤
│       DentalClinic.Core                 │  ← Domain + Application
│   ┌──────────────┬──────────────────┐   │
│   │   Domain     │   Application    │   │
│   │  (Entities)  │  (Services/DTOs) │   │
│   └──────────────┴──────────────────┘   │
├─────────────────────────────────────────┤
│    DentalClinic.Infrastructure          │  ← Persistence, Security, Storage
│   ┌──────────────┬──────────────────┐   │
│   │ Persistence  │    Security      │   │
│   │ (Repositories│  (JWT/BCrypt)    │   │
│   │  + Config)   │                  │   │
│   └──────────────┴──────────────────┘   │
└─────────────────────────────────────────┘
```

---

## 📁 Estrutura do Projeto

### **DentalClinic.Api** (Apresentação)
```
Controllers/
├── AuthController.cs          # Autenticação (login, refresh, logout)
├── PatientsController.cs      # Gestão de pacientes
├── AppointmentsController.cs  # Agendamentos
├── ProntuarioController.cs    # Prontuários eletrônicos
├── EvolutionsController.cs    # Evoluções clínicas
├── TreatmentPlansController.cs # Planos de tratamento
├── ProceduresController.cs    # Procedimentos odontológicos
├── WaitListController.cs      # Lista de espera
├── NotificationsController.cs # Notificações push
├── AnexosController.cs        # Upload de arquivos
├── ClinicsController.cs       # Clínicas/unidades
├── UsersController.cs         # Gestão de usuários
├── LogsController.cs          # Logs de auditoria (LGPD)
└── ReportsController.cs       # Relatórios

Hubs/
└── ClinicHub.cs               # SignalR para tempo real

Middlewares/
└── ExceptionMiddleware.cs     # Tratamento global de exceções

Filters/
└── AuditFilter.cs             # Auditoria LGPD automática
```

### **DentalClinic.Core** (Domínio + Aplicação)
```
Domain/
├── Entities/                  # 21 entidades de domínio
│   ├── User.cs               # Usuário do sistema
│   ├── Patient.cs            # Paciente
│   ├── Appointment.cs        # Agendamento
│   ├── Prontuario.cs         # Prontuário eletrônico
│   ├── Odontogram.cs         # Odontograma
│   ├── Evolution.cs          # Evolução clínica
│   ├── TreatmentPlan.cs      # Plano de tratamento
│   ├── TreatmentItem.cs      # Itens do tratamento
│   ├── Procedure.cs          # Procedimento
│   ├── Anamnese.cs           # Anamnese
│   ├── Prescription.cs       # Prescrição médica
│   ├── MedicalCertificate.cs # Atestado médico
│   ├── WaitListEntry.cs      # Entrada na lista de espera
│   ├── Notification.cs       # Notificação
│   ├── Anexo.cs              # Anexo/arquivo
│   ├── Clinic.cs             # Clínica
│   ├── Specialty.cs          # Especialidade
│   ├── UserSession.cs        # Sessão do usuário
│   ├── LogAuditoria.cs       # Log de auditoria
│   ├── Entity.cs             # Classe base
│   └── Enums.cs              # Enumerações
│
├── ValueObjects/             # Objetos de valor
│   ├── CPF.cs                # Validação de CPF
│   ├── Email.cs              # Validação de email
│   ├── Password.cs           # Hash de senha
│   ├── Address.cs            # Endereço
│   └── Token.cs              # Token JWT
│
└── Repositories/             # Interfaces dos repositórios (13 interfaces)
    ├── IUserRepository.cs
    ├── IPatientRepository.cs
    ├── IAppointmentRepository.cs
    └── ...

Application/
├── DTOs/                     # Data Transfer Objects
│   ├── LoginDto.cs
│   ├── TokenDto.cs
│   └── ...
├── Services/                 # Serviços de aplicação
│   ├── AuthService.cs        # Autenticação
│   ├── AppointmentService.cs # Regras de agendamento
│   └── ...
├── Interfaces/               # Interfaces de serviços
│   ├── IAuthService.cs
│   ├── ITokenService.cs
│   ├── IPasswordHasher.cs
│   └── IStorageService.cs
└── Validators/               # Validações FluentValidation
    └── PatientValidator.cs
```

### **DentalClinic.Infrastructure** (Infraestrutura)
```
Persistence/
├── ApplicationDbContext.cs    # Contexto EF Core
├── Repositories/             # Implementações dos repositórios
│   ├── UserRepository.cs
│   ├── PatientRepository.cs
│   ├── AppointmentRepository.cs
│   └── ...
└── Configurations/           # Configurações EF Core (Fluent API)
    ├── PatientConfiguration.cs
    ├── AppointmentConfiguration.cs
    └── ...

Security/
├── PasswordHasher.cs         # BCrypt para senhas
└── TokenService.cs           # Geração/validação JWT

Storage/
└── LocalStorageService.cs    # Upload de arquivos locais
```

---

## ⚙️ Configuração do Ambiente

### **Pré-requisitos**
- ✅ .NET 9 SDK instalado
- ✅ PostgreSQL 15+ ou Docker
- ✅ Git
- ✅ IDE (VS Code, Rider ou Visual Studio)

### **1. Instalar .NET 9 SDK**
```bash
# Windows/Mac: Baixe em https://dotnet.microsoft.com/download/dotnet/9.0
# Linux (Ubuntu/Debian):
wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get update && sudo apt-get install -y dotnet-sdk-9.0
```

### **2. Configurar Banco de Dados**

#### **Opção A: Docker (Recomendado)**
```bash
# Criar container PostgreSQL
docker run --name odonto-postgres \
  -e POSTGRES_DB=odonto_clinica \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=postgres \
  -p 5432:5432 \
  -d postgres:15

# Verificar se está rodando
docker ps | grep odonto-postgres

# Parar container
docker stop odonto-postgres

# Remover container
docker rm odonto-postgres
```

#### **Opção B: PostgreSQL Local**
```bash
# Instalar PostgreSQL (Ubuntu)
sudo apt-get install postgresql postgresql-contrib

# Acessar psql
sudo -u postgres psql

# Criar banco
CREATE DATABASE odonto_clinica;
\q
```

### **3. Configurar Connection String**

Editar `/workspace/backend/DentalClinic.Api/appsettings.json`:

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Host=localhost;Database=odonto_clinica;Username=postgres;Password=postgres"
  },
  "Jwt": {
    "Key": "SuaChaveSecretaSuperSeguraComPeloMenos32Caracteres!",
    "Issuer": "DentalClinic.Api",
    "Audience": "DentalClinic.App",
    "AccessTokenExpirationMinutes": 60,
    "RefreshTokenExpirationDays": 7
  }
}
```

⚠️ **Importante**: Em produção, use **User Secrets** ou **Azure Key Vault**:
```bash
cd /workspace/backend/DentalClinic.Api
dotnet user-secrets set "Jwt:Key" "MinhaChaveSecretaMuitoLonga32Caracteres!"
```

---

## 🚀 Passo a Passo para Execução

### **Passo 1: Restaurar Dependências**
```bash
cd /workspace/backend
dotnet restore
```

### **Passo 2: Build do Projeto**
```bash
dotnet build --configuration Release
```

### **Passo 3: Aplicar Migrações**
```bash
cd /workspace/backend/DentalClinic.Api

# Opção A: Automático (já configurado no Program.cs)
# O banco é atualizado automaticamente ao iniciar

# Opção B: Manual
dotnet ef database update
```

### **Passo 4: Executar a API**
```bash
# Development (com hot reload)
dotnet watch run --configuration Development

# Production
dotnet run --configuration Release

# Com URL específica
dotnet run --urls="http://localhost:5000;https://localhost:5001"
```

### **Passo 5: Acessar Swagger**
```
📍 http://localhost:5000/swagger
```

---

## 🧪 Testes Unitários

### **1. Criar Projeto de Testes**
```bash
cd /workspace/backend

# Criar projeto xUnit
dotnet new xunit -n DentalClinic.Tests

# Adicionar referências
dotnet add DentalClinic.Tests reference DentalClinic.Core/DentalClinic.Core.csproj
dotnet add DentalClinic.Tests reference DentalClinic.Infrastructure/DentalClinic.Infrastructure.csproj

# Instalar pacotes de teste
dotnet add DentalClinic.Tests package Moq
dotnet add DentalClinic.Tests package FluentAssertions
dotnet add DentalClinic.Tests package Microsoft.EntityFrameworkCore.InMemory
```

### **2. Exemplo: Teste Unitário de Serviço**

**Arquivo**: `DentalClinic.Tests/Services/AuthServiceTests.cs`

```csharp
using Xunit;
using FluentAssertions;
using Moq;
using DentalClinic.Core.Application.Services;
using DentalClinic.Core.Application.DTOs;
using DentalClinic.Core.Domain.Repositories;
using DentalClinic.Core.Application.Interfaces;
using DentalClinic.Core.Domain.Entities;

namespace DentalClinic.Tests.Services;

public class AuthServiceTests
{
    private readonly Mock<IUserRepository> _userRepositoryMock;
    private readonly Mock<IPasswordHasher> _passwordHasherMock;
    private readonly Mock<ITokenService> _tokenServiceMock;
    private readonly Mock<IUserSessionRepository> _sessionRepositoryMock;
    private readonly AuthService _authService;

    public AuthServiceTests()
    {
        _userRepositoryMock = new Mock<IUserRepository>();
        _passwordHasherMock = new Mock<IPasswordHasher>();
        _tokenServiceMock = new Mock<ITokenService>();
        _sessionRepositoryMock = new Mock<IUserSessionRepository>();

        _authService = new AuthService(
            _userRepositoryMock.Object,
            _passwordHasherMock.Object,
            _tokenServiceMock.Object,
            _sessionRepositoryMock.Object,
            new Mock<ILogger<AuthService>>().Object
        );
    }

    [Fact]
    public async Task AuthenticateAsync_UsuarioValido_RetornaSucesso()
    {
        // Arrange
        var loginDto = new LoginDto { Email = "teste@email.com", Password = "senha123" };
        var user = new User(Guid.NewGuid(), "Teste", loginDto.Email, UserRole.Receptionist);
        
        _userRepositoryMock.Setup(r => r.GetByEmailAsync(loginDto.Email))
            .ReturnsAsync(user);
        
        _passwordHasherMock.Setup(p => p.Verify(loginDto.Password, user.PasswordHash))
            .Returns(true);
        
        _tokenServiceMock.Setup(t => t.GenerateAccessToken(user))
            .Returns("access_token_mock");
        
        _tokenServiceMock.Setup(t => t.GenerateRefreshToken())
            .Returns("refresh_token_mock");

        // Act
        var result = await _authService.AuthenticateAsync(loginDto);

        // Assert
        result.Success.Should().BeTrue();
        result.Data.Should().NotBeNull();
        result.Data.AccessToken.Should().Be("access_token_mock");
        result.Data.RefreshToken.Should().Be("refresh_token_mock");
    }

    [Fact]
    public async Task AuthenticateAsync_SenhaInvalida_RetornaErro()
    {
        // Arrange
        var loginDto = new LoginDto { Email = "teste@email.com", Password = "senha_errada" };
        var user = new User(Guid.NewGuid(), "Teste", loginDto.Email, UserRole.Receptionist);
        
        _userRepositoryMock.Setup(r => r.GetByEmailAsync(loginDto.Email))
            .ReturnsAsync(user);
        
        _passwordHasherMock.Setup(p => p.Verify(loginDto.Password, user.PasswordHash))
            .Returns(false);

        // Act
        var result = await _authService.AuthenticateAsync(loginDto);

        // Assert
        result.Success.Should().BeFalse();
        result.Message.Should().Contain("senha");
    }

    [Fact]
    public async Task AuthenticateAsync_UsuarioNaoEncontrado_RetornaErro()
    {
        // Arrange
        var loginDto = new LoginDto { Email = "nao_existe@email.com", Password = "senha123" };
        
        _userRepositoryMock.Setup(r => r.GetByEmailAsync(loginDto.Email))
            .ReturnsAsync((User?)null);

        // Act
        var result = await _authService.AuthenticateAsync(loginDto);

        // Assert
        result.Success.Should().BeFalse();
        result.Message.Should().Contain("não encontrado");
    }
}
```

### **3. Exemplo: Teste Unitário de Repository**

**Arquivo**: `DentalClinic.Tests/Repositories/PatientRepositoryTests.cs`

```csharp
using Xunit;
using FluentAssertions;
using DentalClinic.Infrastructure.Persistence;
using DentalClinic.Infrastructure.Persistence.Repositories;
using DentalClinic.Core.Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace DentalClinic.Tests.Repositories;

public class PatientRepositoryTests : IDisposable
{
    private readonly ApplicationDbContext _context;
    private readonly PatientRepository _repository;

    public PatientRepositoryTests()
    {
        // Configurar banco em memória
        var options = new DbContextOptionsBuilder<ApplicationDbContext>()
            .UseInMemoryDatabase(databaseName: Guid.NewGuid().ToString())
            .Options;

        _context = new ApplicationDbContext(options);
        _repository = new PatientRepository(_context);
    }

    [Fact]
    public async Task AddAsync_PacienteValido_DeveSalvarNoBanco()
    {
        // Arrange
        var patient = new Patient(
            "João Silva",
            "123.456.789-00",
            DateTime.Now.AddYears(-30),
            "joao@email.com"
        );

        // Act
        await _repository.AddAsync(patient);

        // Assert
        var savedPatient = await _context.Patients.FindAsync(patient.Id);
        savedPatient.Should().NotBeNull();
        savedPatient!.Name.Should().Be("João Silva");
    }

    [Fact]
    public async Task GetByIdAsync_PacienteExistente_RetornaPaciente()
    {
        // Arrange
        var patient = new Patient(
            "Maria Santos",
            "987.654.321-00",
            DateTime.Now.AddYears(-25),
            "maria@email.com"
        );
        await _context.Patients.AddAsync(patient);
        await _context.SaveChangesAsync();

        // Act
        var result = await _repository.GetByIdAsync(patient.Id);

        // Assert
        result.Should().NotBeNull();
        result!.Name.Should().Be("Maria Santos");
    }

    [Fact]
    public async Task GetAllAsync_ComFiltro_RetornaApenasFiltrados()
    {
        // Arrange
        await _context.Patients.AddRangeAsync(
            new Patient("Ana Souza", "111.222.333-44", DateTime.Now.AddYears(-20), "ana@email.com"),
            new Patient("Bruno Lima", "555.666.777-88", DateTime.Now.AddYears(-35), "bruno@email.com"),
            new Patient("Carlos Ana", "999.888.777-66", DateTime.Now.AddYears(-40), "carlos@email.com")
        );
        await _context.SaveChangesAsync();

        // Act
        var result = await _repository.GetAllAsync(1, 10, "Ana");

        // Assert
        result.Should().HaveCount(2);
        result.All(p => p.Name.Contains("Ana")).Should().BeTrue();
    }

    [Fact]
    public async Task AnonymizeAsync_DeveOfuscarDadosSensiveis()
    {
        // Arrange
        var patient = new Patient(
            "Pedro Oliveira",
            "123.456.789-00",
            DateTime.Now.AddYears(-50),
            "pedro@email.com"
        );
        await _context.Patients.AddAsync(patient);
        await _context.SaveChangesAsync();

        // Act
        await _repository.AnonymizeAsync(patient.Id);

        // Assert
        var anonymized = await _context.Patients.FindAsync(patient.Id);
        anonymized!.Name.Should().StartWith("ANONIMIZADO");
        anonymized.CPF.Value.Should().NotBe("123.456.789-00");
    }

    public void Dispose()
    {
        _context.Dispose();
    }
}
```

### **4. Executar Testes Unitários**
```bash
cd /workspace/backend/DentalClinic.Tests

# Executar todos os testes
dotnet test

# Executar com cobertura de código
dotnet test --collect:"XPlat Code Coverage"

# Executar apenas testes específicos
dotnet test --filter "FullyQualifiedName~AuthServiceTests"

# Executar em modo verbose
dotnet test -v n
```

---

## 🔗 Testes de Integração

### **1. Configurar WebApplicationFactory**

**Arquivo**: `DentalClinic.Tests/IntegrationTests/CustomWebApplicationFactory.cs`

```csharp
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.EntityFrameworkCore;
using DentalClinic.Infrastructure.Persistence;
using Microsoft.Extensions.DependencyInjection;
using Testcontainers.PostgreSql;

namespace DentalClinic.Tests.IntegrationTests;

public class CustomWebApplicationFactory : WebApplicationFactory<Program>, IAsyncLifetime
{
    private readonly PostgreSqlContainer _postgresContainer = new PostgreSqlBuilder()
        .WithImage("postgres:15")
        .WithDatabase("test_odonto")
        .WithUsername("test")
        .WithPassword("test")
        .Build();

    protected override void ConfigureWebHost(IWebHostBuilder builder)
    {
        builder.ConfigureServices(services =>
        {
            var descriptor = services.SingleOrDefault(
                d => d.ServiceType == typeof(DbContextOptions<ApplicationDbContext>));

            if (descriptor != null)
            {
                services.Remove(descriptor);
            }

            services.AddDbContext<ApplicationDbContext>(options =>
            {
                options.UseNpgsql(_postgresContainer.GetConnectionString());
            });
        });
    }

    public async Task InitializeAsync()
    {
        await _postgresContainer.StartAsync();
    }

    public new async Task DisposeAsync()
    {
        await _postgresContainer.StopAsync();
    }
}
```

### **2. Exemplo: Teste de Integração de Auth**

**Arquivo**: `DentalClinic.Tests/IntegrationTests/AuthIntegrationTests.cs`

```csharp
using System.Net;
using System.Text;
using System.Text.Json;
using Xunit;
using FluentAssertions;
using DentalClinic.Core.Application.DTOs;

namespace DentalClinic.Tests.IntegrationTests;

public class AuthIntegrationTests : IClassFixture<CustomWebApplicationFactory>
{
    private readonly HttpClient _client;
    private readonly JsonSerializerOptions _jsonOptions;

    public AuthIntegrationTests(CustomWebApplicationFactory factory)
    {
        _client = factory.CreateClient();
        _jsonOptions = new JsonSerializerOptions 
        { 
            PropertyNamingPolicy = JsonNamingPolicy.CamelCase 
        };
    }

    [Fact]
    public async Task Login_UsuarioValido_RetornaToken200OK()
    {
        // Arrange
        var loginDto = new LoginDto 
        { 
            Email = "admin@clinica.com", 
            Password = "Admin123!" 
        };
        var content = new StringContent(
            JsonSerializer.Serialize(loginDto),
            Encoding.UTF8,
            "application/json"
        );

        // Act
        var response = await _client.PostAsync("/api/auth/login", content);

        // Assert
        response.StatusCode.Should().Be(HttpStatusCode.OK);
        
        var responseContent = await response.Content.ReadAsStringAsync();
        var tokenDto = JsonSerializer.Deserialize<TokenDto>(responseContent, _jsonOptions);
        
        tokenDto.Should().NotBeNull();
        tokenDto!.AccessToken.Should().NotBeNullOrEmpty();
        tokenDto.RefreshToken.Should().NotBeNullOrEmpty();
    }

    [Fact]
    public async Task Login_SenhaInvalida_Retorna401Unauthorized()
    {
        // Arrange
        var loginDto = new LoginDto 
        { 
            Email = "admin@clinica.com", 
            Password = "SenhaErrada!" 
        };
        var content = new StringContent(
            JsonSerializer.Serialize(loginDto),
            Encoding.UTF8,
            "application/json"
        );

        // Act
        var response = await _client.PostAsync("/api/auth/login", content);

        // Assert
        response.StatusCode.Should().Be(HttpStatusCode.Unauthorized);
    }

    [Fact]
    public async Task Refresh_TokenValido_RetornaNovoToken200OK()
    {
        // Arrange - Primeiro faz login para obter refresh token
        var loginDto = new LoginDto 
        { 
            Email = "admin@clinica.com", 
            Password = "Admin123!" 
        };
        var loginContent = new StringContent(
            JsonSerializer.Serialize(loginDto),
            Encoding.UTF8,
            "application/json"
        );
        var loginResponse = await _client.PostAsync("/api/auth/login", loginContent);
        var loginData = await loginResponse.Content.ReadAsStringAsync();
        var tokenDto = JsonSerializer.Deserialize<TokenDto>(loginData, _jsonOptions);

        var refreshRequest = new RefreshTokenRequest 
        { 
            RefreshToken = tokenDto!.RefreshToken 
        };
        var refreshContent = new StringContent(
            JsonSerializer.Serialize(refreshRequest),
            Encoding.UTF8,
            "application/json"
        );

        // Act
        var refreshResponse = await _client.PostAsync("/api/auth/refresh", refreshContent);

        // Assert
        refreshResponse.StatusCode.Should().Be(HttpStatusCode.OK);
        
        var responseData = await refreshResponse.Content.ReadAsStringAsync();
        var newTokenDto = JsonSerializer.Deserialize<TokenDto>(responseData, _jsonOptions);
        
        newTokenDto!.AccessToken.Should().NotBe(tokenDto.AccessToken);
    }
}
```

### **3. Exemplo: Teste de Integração de Pacientes**

**Arquivo**: `DentalClinic.Tests/IntegrationTests/PatientsIntegrationTests.cs`

```csharp
using System.Net;
using System.Net.Http.Headers;
using System.Text;
using System.Text.Json;
using DentalClinic.Core.Domain.Entities;
using DentalClinic.Core.Domain.ValueObjects;

namespace DentalClinic.Tests.IntegrationTests;

public class PatientsIntegrationTests : IClassFixture<CustomWebApplicationFactory>
{
    private readonly HttpClient _client;
    private readonly JsonSerializerOptions _jsonOptions;
    private string? _authToken;

    public PatientsIntegrationTests(CustomWebApplicationFactory factory)
    {
        _client = factory.CreateClient();
        _jsonOptions = new JsonSerializerOptions 
        { 
            PropertyNamingPolicy = JsonNamingPolicy.CamelCase 
        };
    }

    [Fact]
    public async Task CreatePatient_Autenticado_Retorna201Created()
    {
        // Arrange - Autenticar primeiro
        await AuthenticateAsync();

        var patient = new Patient(
            "Teste Integration",
            "123.456.789-00",
            DateTime.Now.AddYears(-30),
            "teste@integration.com"
        );

        var content = new StringContent(
            JsonSerializer.Serialize(patient),
            Encoding.UTF8,
            "application/json"
        );
        _client.DefaultRequestHeaders.Authorization = 
            new AuthenticationHeaderValue("Bearer", _authToken);

        // Act
        var response = await _client.PostAsync("/api/patients", content);

        // Assert
        response.StatusCode.Should().Be(HttpStatusCode.Created);
        
        var responseData = await response.Content.ReadAsStringAsync();
        var createdPatient = JsonSerializer.Deserialize<Patient>(responseData, _jsonOptions);
        
        createdPatient.Should().NotBeNull();
        createdPatient!.Name.Should().Be("Teste Integration");
    }

    [Fact]
    public async Task GetPatients_SemAutenticacao_Retorna401Unauthorized()
    {
        // Act
        var response = await _client.GetAsync("/api/patients");

        // Assert
        response.StatusCode.Should().Be(HttpStatusCode.Unauthorized);
    }

    [Fact]
    public async Task GetPatients_ComAutenticacao_RetornaLista200OK()
    {
        // Arrange
        await AuthenticateAsync();
        _client.DefaultRequestHeaders.Authorization = 
            new AuthenticationHeaderValue("Bearer", _authToken);

        // Act
        var response = await _client.GetAsync("/api/patients?page=1&pageSize=10");

        // Assert
        response.StatusCode.Should().Be(HttpStatusCode.OK);
        
        var responseData = await response.Content.ReadAsStringAsync();
        var json = JsonDocument.Parse(responseData);
        
        json.RootElement.GetProperty("items").GetArrayLength().Should().BeGreaterOrEqualTo(0);
    }

    private async Task AuthenticateAsync()
    {
        var loginDto = new LoginDto 
        { 
            Email = "admin@clinica.com", 
            Password = "Admin123!" 
        };
        var content = new StringContent(
            JsonSerializer.Serialize(loginDto),
            Encoding.UTF8,
            "application/json"
        );
        
        var response = await _client.PostAsync("/api/auth/login", content);
        response.EnsureSuccessStatusCode();
        
        var responseData = await response.Content.ReadAsStringAsync();
        var tokenDto = JsonSerializer.Deserialize<TokenDto>(responseData, _jsonOptions);
        
        _authToken = tokenDto!.AccessToken;
    }
}
```

### **4. Executar Testes de Integração**
```bash
cd /workspace/backend/DentalClinic.Tests

# Executar apenas testes de integração
dotnet test --filter "FullyQualifiedName~IntegrationTests"

# Executar todos os testes
dotnet test

# Com cobertura e relatório HTML
dotnet test --collect:"XPlat Code Coverage" --logger "html;LogFileName=coverage-report.html"
```

---

## 🧑‍💻 Testes Manuais via Swagger

### **1. Acessar Swagger UI**
```
http://localhost:5000/swagger
```

### **2. Fluxo de Teste Completo**

#### **Passo 1: Autenticação**
1. Expandir endpoint `POST /api/Auth/login`
2. Clicar em "Try it out"
3. Preencher body:
```json
{
  "email": "admin@clinica.com",
  "password": "Admin123!"
}
```
4. Clicar em "Execute"
5. Copiar o `accessToken` da resposta

#### **Passo 2: Configurar Autorização**
1. Clicar no botão "Authorize" no topo
2. Inserir: `Bearer {seu_access_token}`
3. Clicar em "Authorize"

#### **Passo 3: Testar CRUD de Pacientes**

**Criar Paciente (POST /api/Patients)**:
```json
{
  "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
  "name": "João da Silva",
  "cpf": "123.456.789-00",
  "dateOfBirth": "1990-05-15",
  "email": "joao.silva@email.com",
  "phone": "(11) 99999-9999",
  "address": {
    "street": "Rua das Flores",
    "number": "123",
    "complement": "Apto 45",
    "neighborhood": "Centro",
    "city": "São Paulo",
    "state": "SP",
    "zipCode": "01234-567"
  }
}
```

**Listar Pacientes (GET /api/Patients)**:
```
?page=1&pageSize=10&searchTerm=João
```

**Buscar por ID (GET /api/Patients/{id})**:
```
/id: 3fa85f64-5717-4562-b3fc-2c963f66afa6
```

**Atualizar Paciente (PUT /api/Patients/{id})**:
```json
{
  "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
  "name": "João da Silva Atualizado",
  "cpf": "123.456.789-00",
  "dateOfBirth": "1990-05-15",
  "email": "joao.atualizado@email.com",
  "phone": "(11) 98888-8888"
}
```

**Anonimizar (LGPD) (POST /api/Patients/{id}/anonymize)**:
```
/id: 3fa85f64-5717-4562-b3fc-2c963f66afa6
```
⚠️ Requer role **Admin**

#### **Passo 4: Testar Agendamentos**

**Criar Agendamento (POST /api/Appointments)**:
```json
{
  "patientId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
  "professionalId": "usuario-id-aqui",
  "startTime": "2025-02-01T09:00:00Z",
  "endTime": "2025-02-01T10:00:00Z",
  "status": "Scheduled",
  "observations": "Primeira consulta"
}
```

**Listar Agendamentos (GET /api/Appointments)**:
```
?startDate=2025-02-01&endDate=2025-02-28&status=Scheduled
```

#### **Passo 5: Testar Prontuário**

**Criar Prontuário (POST /api/Prontuario)**:
```json
{
  "patientId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
  "anamnesis": {
    "chiefComplaint": "Dor de dente",
    "medicalHistory": "Hipertensão controlada",
    "allergies": "Nenhuma"
  }
}
```

**Adicionar Evolução (POST /api/Evolutions)**:
```json
{
  "prontuarioId": "prontuario-id-aqui",
  "description": "Paciente relata melhora da dor",
  "procedurePerformed": "Restauração classe II"
}
```

---

## 📡 Endpoints Detalhados

### **Autenticação**
| Método | Endpoint | Descrição | Auth | Body |
|--------|----------|-----------|------|------|
| POST | `/api/Auth/login` | Login | ❌ | `{email, password}` |
| POST | `/api/Auth/refresh` | Renovar token | ❌ | `{refreshToken}` |
| POST | `/api/Auth/logout` | Logout | ✅ | - |

### **Pacientes**
| Método | Endpoint | Descrição | Auth | Roles |
|--------|----------|-----------|------|-------|
| GET | `/api/Patients` | Listar (paginado) | ✅ | Todos |
| GET | `/api/Patients/{id}` | Buscar por ID | ✅ | Todos |
| POST | `/api/Patients` | Criar | ✅ | Admin, Receptionist |
| PUT | `/api/Patients/{id}` | Atualizar | ✅ | Admin, Receptionist |
| POST | `/api/Patients/{id}/anonymize` | Anonimizar (LGPD) | ✅ | Admin |

### **Agendamentos**
| Método | Endpoint | Descrição | Query Params |
|--------|----------|-----------|--------------|
| GET | `/api/Appointments` | Listar | `?startDate, endDate, status, professionalId` |
| GET | `/api/Appointments/{id}` | Buscar por ID | - |
| POST | `/api/Appointments` | Criar | `{patientId, professionalId, startTime, endTime}` |
| PUT | `/api/Appointments/{id}` | Atualizar | - |
| DELETE | `/api/Appointments/{id}` | Cancelar | - |

### **Prontuário**
| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | `/api/Prontuario/patient/{patientId}` | Buscar por paciente |
| POST | `/api/Prontuario` | Criar prontuário |
| PUT | `/api/Prontuario/{id}` | Atualizar |
| POST | `/api/Prontuario/{id}/odontogram` | Atualizar odontograma |

### **Evoluções**
| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | `/api/Evolutions/prontuario/{prontuarioId}` | Listar evoluções |
| POST | `/api/Evolutions` | Criar evolução |

### **Planos de Tratamento**
| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | `/api/TreatmentPlans/patient/{patientId}` | Listar planos |
| POST | `/api/TreatmentPlans` | Criar plano |
| PUT | `/api/TreatmentPlans/{id}` | Atualizar |

### **Lista de Espera**
| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | `/api/WaitList` | Listar entradas |
| POST | `/api/WaitList` | Adicionar à lista |
| PUT | `/api/WaitList/{id}/call` | Chamar paciente |

### **Notificações**
| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | `/api/Notifications` | Listar notificações do usuário |
| PUT | `/api/Notifications/{id}/read` | Marcar como lida |

### **Anexos**
| Método | Endpoint | Descrição |
|--------|----------|-----------|
| POST | `/api/Anexos` | Upload de arquivo |
| GET | `/api/Anexos/{id}` | Download |
| DELETE | `/api/Anexos/{id}` | Deletar |

### **Logs de Auditoria (LGPD)**
| Método | Endpoint | Descrição | Roles |
|--------|----------|-----------|-------|
| GET | `/api/Logs` | Listar logs | Admin |
| GET | `/api/Logs/{id}` | Detalhes do log | Admin |

### **Relatórios**
| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | `/api/Reports/appointments` | Relatório de agendamentos |
| GET | `/api/Reports/patients` | Relatório de pacientes |
| GET | `/api/Reports/procedures` | Relatório de procedimentos |

---

## 📡 SignalR - Tempo Real

### **Configuração no Backend**

O Hub está configurado em `/workspace/backend/DentalClinic.Api/Hubs/ClinicHub.cs`:

```csharp
// Endpoint do Hub
/hubs/clinic
```

### **Métodos Disponíveis**

| Método | Descrição | Parâmetros |
|--------|-----------|------------|
| `JoinPatientGroup` | Entrar no grupo de um paciente | `patientId` (string) |
| `LeavePatientGroup` | Sair do grupo de um paciente | `patientId` (string) |
| `NotifyOdontogramUpdate` | Notificar atualização do odontograma | `patientId`, `updateData` |

### **Eventos Enviados pelo Servidor**

| Evento | Descrição | Payload |
|--------|-----------|---------|
| `ReceiveOdontogramUpdate` | Atualização do odontograma | `updateData` (object) |
| `ReceiveNotification` | Nova notificação | `notification` (object) |
| `ReceiveAppointmentChange` | Mudança no agendamento | `appointment` (object) |

### **Testar SignalR Manualmente**

#### **Opção 1: Usando Postman**
1. Instalar extensão "Postman Interceptor"
2. Criar nova requisição WebSocket
3. URL: `ws://localhost:5000/hubs/clinic`
4. Enviar mensagem JSON:
```json
{
  "target": "JoinPatientGroup",
  "arguments": ["patient-id-aqui"]
}
```

#### **Opção 2: Usando JavaScript Console**
```javascript
const connection = new signalR.HubConnectionBuilder()
    .withUrl("http://localhost:5000/hubs/clinic")
    .build();

connection.on("ReceiveOdontogramUpdate", (data) => {
    console.log("Odontograma atualizado:", data);
});

connection.on("ReceiveNotification", (notification) => {
    console.log("Nova notificação:", notification);
});

await connection.start();
console.log("SignalR conectado!");

// Entrar no grupo de um paciente
await connection.invoke("JoinPatientGroup", "patient-id-aqui");
```

---

## 🔒 Segurança e LGPD

### **Autenticação JWT**

**Configuração em `appsettings.json`**:
```json
{
  "Jwt": {
    "Key": "SuaChaveSecretaSuperSeguraComPeloMenos32Caracteres!",
    "Issuer": "DentalClinic.Api",
    "Audience": "DentalClinic.App",
    "AccessTokenExpirationMinutes": 60,
    "RefreshTokenExpirationDays": 7
  }
}
```

**Claims no Token**:
- `NameIdentifier`: ID do usuário
- `Email`: Email do usuário
- `Role`: Cargo (Admin, Dentist, Receptionist)
- `exp`: Expiração

### **Roles e Permissões**

| Role | Permissões |
|------|------------|
| **Admin** | Acesso total, incluindo anonimização LGPD |
| **Dentist** | Prontuários, evoluções, agendamentos próprios |
| **Receptionist** | Cadastro de pacientes, agendamentos gerais |

### **Conformidade LGPD**

#### **1. Auditoria Automática**
O `AuditFilter` registra automaticamente:
- Quem acessou quais dados
- Quando foi o acesso
- Qual IP foi utilizado
- Qual operação foi realizada

#### **2. Anonimização de Dados**
Endpoint: `POST /api/Patients/{id}/anonymize`

**O que é anonimizado**:
- Nome → "ANONIMIZADO_{guid}"
- CPF → "***.***.***-**"
- Email → "anonimo_{guid}@anonimo.com"
- Telefone → "(**) *****-****"
- Endereço → Dados removidos

#### **3. Logs de Acesso**
Endpoint: `GET /api/Logs`

**Retorna**:
```json
{
  "id": "log-id",
  "usuarioId": "user-id",
  "acao": "GET /api/patients/123",
  "ipAddress": "192.168.1.100",
  "dataHora": "2025-01-30T10:30:00Z",
  "detalhes": "{\"Query\": \"\", \"StatusCode\": 200}"
}
```

### **Testar Segurança**

#### **Teste 1: Acessar sem Token**
```bash
curl http://localhost:5000/api/patients
# Expected: 401 Unauthorized
```

#### **Teste 2: Token Expirado**
```bash
curl -H "Authorization: Bearer token_expirado" \
     http://localhost:5000/api/patients
# Expected: 401 Unauthorized
```

#### **Teste 3: Acesso sem Permissão**
```bash
# Tentar anonimizar como Recepcionista
curl -X POST \
  -H "Authorization: Bearer token_recepcionista" \
  http://localhost:5000/api/patients/{id}/anonymize
# Expected: 403 Forbidden
```

---

## 🐛 Troubleshooting

### **Erro: "The NPGSQL connection failed"**
```bash
# Verificar se PostgreSQL está rodando
docker ps | grep postgres

# Se não estiver, iniciar
docker start odonto-postgres

# Testar conexão
psql -h localhost -U postgres -d odonto_clinica
```

### **Erro: "Migration pending"**
```bash
cd /workspace/backend/DentalClinic.Api

# Forçar migração
dotnet ef database update --force
```

### **Erro: "JWT signature validation failed"**
```bash
# Verificar se a chave JWT é igual no appsettings e no cliente
# A chave deve ter pelo menos 32 caracteres
```

### **Erro: "CORS policy failed"**
```csharp
// Verificar em Program.cs se CORS está configurado corretamente
app.UseCors("AllowFlutter");
```

### **Erro: "Cannot access disposed object"**
```csharp
// Em testes, garantir que o contexto seja criado por teste
// Usar databaseName único para cada teste
.UseInMemoryDatabase(databaseName: Guid.NewGuid().ToString())
```

### **Logs Detalhados**
```bash
# Executar com logs em nível Debug
dotnet run --configuration Development --verbosity detailed

# Ou modificar appsettings.json
{
  "Logging": {
    "LogLevel": {
      "Default": "Debug",
      "Microsoft.EntityFrameworkCore": "Information"
    }
  }
}
```

### **Performance Issues**
```bash
# Habilitar SQL logging para ver queries lentas
{
  "Logging": {
    "LogLevel": {
      "Microsoft.EntityFrameworkCore.Database.Command": "Information"
    }
  }
}
```

---

## 📊 Checklist de Validação

### **Setup**
- [ ] .NET 9 SDK instalado
- [ ] PostgreSQL rodando (Docker ou local)
- [ ] Connection String configurada
- [ ] Migrações aplicadas

### **Execução**
- [ ] API inicia sem erros
- [ ] Swagger acessível em http://localhost:5000/swagger
- [ ] Login funciona com credenciais válidas
- [ ] Token JWT é gerado corretamente

### **Testes Unitários**
- [ ] Projeto de testes criado
- [ ] Testes de AuthService passando
- [ ] Testes de repositories passando
- [ ] Cobertura > 80%

### **Testes de Integração**
- [ ] Testcontainer PostgreSQL configurado
- [ ] Testes de auth passando
- [ ] Testes de CRUD passando
- [ ] Testes isolados (rollback após cada teste)

### **Testes Manuais**
- [ ] Login via Swagger
- [ ] CRUD de pacientes completo
- [ ] Agendamentos funcionando
- [ ] Prontuários criando/visualizando
- [ ] Upload de anexos
- [ ] SignalR recebendo eventos

### **Segurança**
- [ ] Endpoints protegidos retornam 401 sem token
- [ ] Roles funcionando (Admin vs Recepcionista)
- [ ] Anonimização LGPD funcionando
- [ ] Logs de auditoria sendo gravados

### **Performance**
- [ ] Response time < 200ms (P95)
- [ ] Queries otimizadas (sem N+1)
- [ ] Paginação funcionando corretamente

---

## 🎯 Próximos Passos

1. **Implementar mais testes unitários** para todas as services
2. **Criar testes de carga** com k6 ou JMeter
3. **Configurar CI/CD** com GitHub Actions
4. **Implementar health checks** (`/health`, `/ready`)
5. **Adicionar métricas** com Prometheus + Grafana
6. **Configurar distributed tracing** com OpenTelemetry

---

**Documento criado**: 2025-01-30  
**Versão**: 1.0  
**Autor**: Assistant
