# 🧪 GUIA COMPLETO DE TESTAGEM DO BACKEND - OdontoClinica Universitária

## 📋 Índice

1. [Pré-requisitos Detalhados](#1-pré-requisitos-detalhados)
2. [Configuração do Ambiente de Desenvolvimento](#2-configuração-do-ambiente-de-desenvolvimento)
3. [Configuração do Banco de Dados](#3-configuração-do-banco-de-dados)
4. [Primeira Execução da API](#4-primeira-execução-da-api)
5. [Testes Manuais via Swagger](#5-testes-manuais-via-swagger)
6. [Criação de Projeto de Testes Unitários](#6-criação-de-projeto-de-testes-unitários)
7. [Testes Unitários - Exemplos Práticos](#7-testes-unitários---exemplos-práticos)
8. [Testes de Integração](#8-testes-de-integração)
9. [Testes de Performance](#9-testes-de-performance)
10. [Checklist de Validação Completo](#10-checklist-de-validação-completo)
11. [Troubleshooting](#11-troubleshooting)

---

## 1. Pré-requisitos Detalhados

### 1.1. Ferramentas Necessárias

| Ferramenta | Versão Mínima | Como Instalar |
|------------|---------------|---------------|
| .NET SDK | 9.0+ | `wget https://dot.net/v1/dotnet-install.sh && chmod +x dotnet-install.sh && ./dotnet-install.sh --channel 9.0` |
| PostgreSQL | 15+ | `docker run --name odonto-postgres -e POSTGRES_PASSWORD=postgres -p 5432:5432 -d postgres:15` |
| Docker (opcional) | 20.10+ | `curl -fsSL https://get.docker.com | sh` |
| Git | 2.30+ | `apt-get install git` |
| VS Code / Rider | - | Download oficial |

### 1.2. Verificar Instalações

```bash
# Verificar versão do .NET
dotnet --version
# Esperado: 9.0.x

# Verificar se o PostgreSQL está acessível
psql -h localhost -U postgres -c "SELECT version();"
# Ou via Docker:
docker ps | grep odonto-postgres

# Verificar portas em uso
netstat -tlnp | grep -E '5432|5000|5001'
```

---

## 2. Configuração do Ambiente de Desenvolvimento

### 2.1. Estrutura do Projeto Backend

```
backend/
├── DentalClinic.sln                    # Solution file
├── DentalClinic.Api/                   # Camada de Apresentação (API REST)
│   ├── Controllers/                    # 14 controllers REST
│   │   ├── AuthController.cs           # Autenticação e tokens
│   │   ├── PatientsController.cs       # Gestão de pacientes
│   │   ├── AppointmentsController.cs   # Agenda
│   │   ├── ProntuarioController.cs     # Prontuário eletrônico
│   │   ├── UsersController.cs          # Gestão de usuários
│   │   ├── ClinicsController.cs        # Clínicas
│   │   ├── ProceduresController.cs     # Procedimentos
│   │   ├── EvolutionsController.cs     # Evoluções clínicas
│   │   ├── TreatmentPlansController.cs # Planos de tratamento
│   │   ├── WaitListController.cs       # Lista de espera
│   │   ├── NotificationsController.cs  # Notificações
│   │   ├── ReportsController.cs        # Relatórios
│   │   ├── LogsController.cs           # Logs de auditoria
│   │   └── AnexosController.cs         # Anexos de arquivos
│   ├── Hubs/
│   │   └── ClinicHub.cs                # SignalR para tempo real
│   ├── Filters/
│   │   └── AuditFilter.cs              # Filtro de auditoria LGPD
│   ├── Middlewares/
│   │   └── ExceptionMiddleware.cs      # Tratamento global de erros
│   ├── Program.cs                      # Configuração DI, JWT, CORS, Swagger
│   └── appsettings.json                # Configurações (Connection String, JWT)
├── DentalClinic.Core/                  # Camada de Domínio e Aplicação
│   ├── Domain/
│   │   ├── Entities/                   # 21 entidades (User, Patient, Appointment, etc.)
│   │   ├── Repositories/               # 13 interfaces de repositório
│   │   └── ValueObjects/               # CPF, Email, Address, etc.
│   ├── Application/
│   │   ├── DTOs/                       # Data Transfer Objects
│   │   ├── Interfaces/                 # Interfaces de serviços
│   │   └── Services/                   # Serviços de negócio (AuthService, etc.)
│   └── Common/                         # Classes utilitárias (Result, DomainEvent)
└── DentalClinic.Infrastructure/        # Camada de Infraestrutura
    ├── Persistence/
    │   ├── ApplicationDbContext.cs     # DbContext do EF Core
    │   └── Repositories/               # 13 implementações de repositórios
    ├── Security/
    │   ├── PasswordHasher.cs           # BCrypt para senhas
    │   └── TokenService.cs             # Geração de JWT
    └── Storage/
        └── LocalStorageService.cs      # Upload de arquivos
```

### 2.2. Restaurar Dependências

```bash
cd /workspace/backend

# Restaurar todos os pacotes NuGet
dotnet restore DentalClinic.sln

# Verificar se há erros
if [ $? -eq 0 ]; then
    echo "✅ Restore concluído com sucesso!"
else
    echo "❌ Erro no restore. Verifique sua conexão com a internet."
    exit 1
fi
```

### 2.3. Build do Projeto

```bash
# Build em modo Debug
dotnet build DentalClinic.sln --configuration Debug

# Build em modo Release (otimizado)
dotnet build DentalClinic.sln --configuration Release

# Verificar warnings e erros
dotnet build DentalClinic.sln --verbosity minimal
```

---

## 3. Configuração do Banco de Dados

### 3.1. Opção 1: Docker (Recomendado)

```bash
# Parar container existente (se houver)
docker stop odonto-postgres 2>/dev/null || true
docker rm odonto-postgres 2>/dev/null || true

# Criar novo container
docker run --name odonto-postgres \
  -e POSTGRES_DB=odonto_clinica \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=postgres \
  -p 5432:5432 \
  -v odonto_data:/var/lib/postgresql/data \
  -d postgres:15

# Aguardar inicialização (30 segundos)
echo "⏳ Aguardando PostgreSQL iniciar..."
sleep 30

# Verificar se está rodando
docker ps | grep odonto-postgres

# Testar conexão
docker exec -it odonto-postgres psql -U postgres -d odonto_clinica -c "SELECT version();"
```

### 3.2. Opção 2: PostgreSQL Local

```bash
# Instalar PostgreSQL (Ubuntu/Debian)
sudo apt-get update
sudo apt-get install -y postgresql postgresql-contrib

# Iniciar serviço
sudo systemctl start postgresql
sudo systemctl enable postgresql

# Criar banco de dados
sudo -u postgres psql <<EOF
CREATE DATABASE odonto_clinica;
\du
-- Se usuário não existir:
-- CREATE USER postgres WITH PASSWORD 'postgres';
-- GRANT ALL PRIVILEGES ON DATABASE odonto_clinica TO postgres;
EOF
```

### 3.3. Configurar Connection String

Editar `/workspace/backend/DentalClinic.Api/appsettings.json`:

```json
{
  "ConnectionStrings": {
    // Para Docker ou localhost
    "DefaultConnection": "Host=localhost;Database=odonto_clinica;Username=postgres;Password=postgres"
    
    // Para Docker com IP específico (Windows/Mac)
    // "DefaultConnection": "Host=host.docker.internal;Database=odonto_clinica;Username=postgres;Password=postgres"
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

**⚠️ IMPORTANTE:** Em produção, use variáveis de ambiente ou Azure Key Vault!

### 3.4. Aplicar Migrações

```bash
cd /workspace/backend/DentalClinic.Api

# Verificar migrações pendentes
dotnet ef migrations list

# Aplicar todas as migrações ao banco
dotnet ef database update

# Verificar tabelas criadas
docker exec -it odonto-postgres psql -U postgres -d odonto_clinica -c "\dt"

# Esperado ver:
# - Users
# - Patients
# - Appointments
# - Prontuarios
# - UserSessions
# - LogAuditorias
# - ... (21 tabelas no total)
```

### 3.5. Script SQL de Verificação

```sql
-- Conectar ao banco e verificar estrutura
docker exec -it odonto-postgres psql -U postgres -d odonto_clinica <<EOF

-- Listar todas as tabelas
\dt

-- Contar registros iniciais
SELECT 
    'Users' as tabela, COUNT(*) as registros FROM "Users"
UNION ALL
SELECT 'Patients', COUNT(*) FROM "Patients"
UNION ALL
SELECT 'Appointments', COUNT(*) FROM "Appointments";

-- Verificar estrutura da tabela Users
\d "Users"

EOF
```

---

## 4. Primeira Execução da API

### 4.1. Executar em Modo Development

```bash
cd /workspace/backend/DentalClinic.Api

# Executar API
dotnet run --configuration Development

# Ou com URL específica
dotnet run --urls "http://localhost:5000"

# Ou em background (para testes)
dotnet run > api.log 2>&1 &
API_PID=$!
echo "API iniciada com PID: $API_PID"
```

### 4.2. Verificar Logs de Inicialização

A API deve mostrar no console:

```
Now listening on: http://localhost:5000
Application started. Press Ctrl+C to shut down.
Hosting environment: Development
Content root path: /workspace/backend/DentalClinic.Api

Informações importantes:
- ✅ PostgreSQL conectado
- ✅ Migrações aplicadas automaticamente
- ✅ JWT configurado
- ✅ Swagger disponível em /swagger
- ✅ SignalR Hub registrado em /hubs/clinic
```

### 4.3. Acessar Swagger

Abrir navegador em: **http://localhost:5000/swagger**

Você deve ver:
- 14 endpoints agrupados por controller
- Botão "Authorize" para configurar JWT
- Schema completo das entidades

### 4.4. Teste Rápido de Saúde

```bash
# Testar se API está respondendo
curl -X GET http://localhost:5000/api/health 2>/dev/null || echo "Endpoint de health não implementado"

# Listar endpoints disponíveis
curl -s http://localhost:5000/swagger/v1/swagger.json | jq '.paths | keys'
```

---

## 5. Testes Manuais via Swagger

### 5.1. Fluxo Completo de Autenticação

#### Passo 1: Criar Usuário Admin (via Script SQL)

```bash
docker exec -it odonto-postgres psql -U postgres -d odonto_clinica <<EOF

-- Inserir usuário admin manualmente (senha: Admin@123)
INSERT INTO "Users" (
    "Id", "Name", "Email", "PasswordHash", "Role", 
    "IsActive", "CreatedAt", "UpdatedAt"
) VALUES (
    '00000000-0000-0000-0000-000000000001',
    'Administrador',
    'admin@odonto.com',
    '\$2a\$11\$Zz...hash_da_senha_Admin123...',
    0,  -- Admin = 0
    true,
    NOW(),
    NOW()
);

-- Nota: Use o PasswordHasher para gerar o hash correto
-- Ou crie via endpoint de registro se disponível

EOF
```

#### Passo 2: Login via Swagger

1. Acesse **http://localhost:5000/swagger**
2. Expanda **AuthController**
3. Clique em **POST /api/Auth/login**
4. Clique em "Try it out"
5. Preencha o body:

```json
{
  "email": "admin@odonto.com",
  "password": "Admin@123"
}
```

6. Clique em "Execute"

**Resposta esperada (200 OK):**

```json
{
  "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "refreshToken": "dGhpcyBpcyBhIHJhbmRvbSByZWZyZXNoIHRva2Vu...",
  "user": {
    "id": "00000000-0000-0000-0000-000000000001",
    "name": "Administrador",
    "email": "admin@odonto.com",
    "role": "Admin"
  }
}
```

7. **Copie o `accessToken`** para usar nos próximos testes.

#### Passo 3: Configurar Autorização no Swagger

1. Clique no botão **"Authorize"** no topo da página
2. Em "Value", digite: `Bearer {seu_access_token_aqui}`
3. Clique em "Authorize"
4. Feche o modal

Agora todos os endpoints protegidos estarão disponíveis!

### 5.2. Testar Endpoint de Pacientes

#### Criar Paciente

1. Expanda **PatientsController**
2. Clique em **POST /api/Patients**
3. Preencha o body:

```json
{
  "name": "João da Silva",
  "cpf": "12345678901",
  "dateOfBirth": "1990-05-15",
  "email": "joao.silva@email.com",
  "phone": "(11) 98765-4321",
  "address": {
    "street": "Rua das Flores",
    "number": "123",
    "complement": "Apto 45",
    "neighborhood": "Centro",
    "city": "São Paulo",
    "state": "SP",
    "zipCode": "01234-567"
  },
  "documentNumber": "RG123456789",
  "responsibleName": null,
  "responsiblePhone": null
}
```

4. Execute e verifique resposta **201 Created**

#### Listar Pacientes

1. Clique em **GET /api/Patients**
2. Execute com parâmetros:
   - page: 1
   - pageSize: 10
   - searchTerm: "João"

**Resposta esperada:**

```json
{
  "items": [
    {
      "id": "...",
      "name": "João da Silva",
      "cpf": {"value": "12345678901"},
      "email": {"value": "joao.silva@email.com"},
      ...
    }
  ],
  "total": 1,
  "page": 1,
  "pageSize": 10
}
```

### 5.3. Testar Agenda (Appointments)

#### Criar Agendamento

```json
// POST /api/Appointments
{
  "patientId": "{id_do_paciente_criado}",
  "professionalId": "{id_do_admin}",
  "startTime": "2025-08-01T14:00:00Z",
  "endTime": "2025-08-01T15:00:00Z",
  "procedureType": "Consulta",
  "status": "Scheduled",
  "observations": "Primeira consulta do paciente"
}
```

### 5.4. Testar Prontuário Eletrônico

#### Criar Prontuário

```json
// POST /api/Prontuario
{
  "patientId": "{id_do_paciente}",
  "chiefComplaint": "Dor de dente",
  "medicalHistory": "Hipertensão controlada",
  "clinicalExam": "Dente 36 com cárie profunda",
  "diagnosis": "Pulpite irreversível",
  "treatmentPlan": "Tratamento endodôntico",
  "odontogram": {
    "tooth": "36",
    "surface": "Oclusal",
    "condition": "Caries"
  }
}
```

### 5.5. Testar SignalR (Tempo Real)

Use o **Postman** ou **wscat** para testar o hub:

```bash
# Instalar wscat
npm install -g wscat

# Conectar ao hub
wscat -c ws://localhost:5000/hubs/clinic

# Após conectar, o hub aceitará métodos como:
# - JoinPatientGroup
# - NotifyOdontogramUpdate
```

---

## 6. Criação de Projeto de Testes Unitários

### 6.1. Criar Projeto de Testes

```bash
cd /workspace/backend

# Criar projeto de testes xUnit
dotnet new xunit -n DentalClinic.Tests --framework net9.0

# Adicionar referências aos projetos principais
dotnet add DentalClinic.Tests/DentalClinic.Tests.csproj reference DentalClinic.Core/DentalClinic.Core.csproj
dotnet add DentalClinic.Tests/DentalClinic.Tests.csproj reference DentalClinic.Infrastructure/DentalClinic.Infrastructure.csproj

# Adicionar pacotes de teste
dotnet add DentalClinic.Tests package Moq --version 4.20.70
dotnet add DentalClinic.Tests package FluentAssertions --version 6.12.0
dotnet add DentalClinic.Tests package Microsoft.EntityFrameworkCore.InMemory --version 9.0.0
dotnet add DentalClinic.Tests package coverlet.collector --version 6.0.0

# Verificar estrutura criada
ls -la DentalClinic.Tests/
```

### 6.2. Estrutura de Pastas de Testes

```
DentalClinic.Tests/
├── UnitTests/
│   ├── Domain/
│   │   ├── Entities/
│   │   │   ├── PatientTests.cs
│   │   │   ├── UserTests.cs
│   │   │   └── AppointmentTests.cs
│   │   └── ValueObjects/
│   │       ├── CpfTests.cs
│   │       └── EmailTests.cs
│   ├── Application/
│   │   ├── Services/
│   │   │   ├── AuthServiceTests.cs
│   │   │   └── AppointmentServiceTests.cs
│   │   └── DTOs/
│   └── Infrastructure/
│       ├── Repositories/
│       │   ├── PatientRepositoryTests.cs
│       │   └── UserRepositoryTests.cs
│       └── Security/
│           ├── TokenServiceTests.cs
│           └── PasswordHasherTests.cs
├── IntegrationTests/
│   ├── Controllers/
│   │   ├── AuthControllerTests.cs
│   │   └── PatientsControllerTests.cs
│   └── Hubs/
│       └── ClinicHubTests.cs
├── Fixtures/
│   └── DatabaseFixture.cs
├── DentalClinic.Tests.csproj
└── UnitTest1.cs (pode deletar)
```

---

## 7. Testes Unitários - Exemplos Práticos

### 7.1. Teste de Entidade Patient

Criar arquivo: `DentalClinic.Tests/UnitTests/Domain/Entities/PatientTests.cs`

```csharp
using DentalClinic.Core.Domain.Entities;
using DentalClinic.Core.Domain.ValueObjects;
using FluentAssertions;
using Xunit;

namespace DentalClinic.Tests.UnitTests.Domain.Entities;

public class PatientTests
{
    [Fact]
    public void Create_WithValidData_ShouldCreatePatient()
    {
        // Arrange
        var name = "João da Silva";
        var cpf = "12345678901";
        var dateOfBirth = new DateTime(1990, 5, 15);
        var email = "joao@email.com";
        var phone = "(11) 98765-4321";
        var address = Address.Create(
            "Rua das Flores", "123", "Apto 45", 
            "Centro", "São Paulo", "SP", "01234-567"
        );
        var documentNumber = "RG123456789";

        // Act
        var patient = Patient.Create(
            name, cpf, dateOfBirth, email, phone, 
            address, documentNumber
        );

        // Assert
        patient.Should().NotBeNull();
        patient.Name.Should().Be(name);
        patient.CPF.Value.Should().Be(cpf);
        patient.DateOfBirth.Should().Be(dateOfBirth);
        patient.EmailAddress.Value.Should().Be(email);
        patient.Phone.Should().Be(phone);
        patient.Status.Should().Be(PatientStatus.Active);
    }

    [Theory]
    [InlineData("")]
    [InlineData("  ")]
    [InlineData("Jo")]  // Nome muito curto
    public void Create_WithInvalidName_ShouldThrowException(string invalidName)
    {
        // Arrange
        var cpf = "12345678901";
        var dateOfBirth = new DateTime(1990, 5, 15);
        var email = "joao@email.com";
        var phone = "(11) 98765-4321";
        var address = Address.Create(
            "Rua das Flores", "123", null, 
            "Centro", "São Paulo", "SP", "01234-567"
        );
        var documentNumber = "RG123456789";

        // Act & Assert
        var act = () => Patient.Create(
            invalidName, cpf, dateOfBirth, email, phone, 
            address, documentNumber
        );

        act.Should().Throw<InvalidOperationException>()
            .WithMessage("*Nome*");
    }

    [Fact]
    public void GetAge_ShouldReturnCorrectAge()
    {
        // Arrange
        var dateOfBirth = new DateTime(2000, 1, 1);
        var patient = Patient.Create(
            "Teste", "12345678901", dateOfBirth, 
            "teste@email.com", "(11) 98765-4321",
            Address.Create("Rua", "1", null, "Bairro", "Cidade", "SP", "00000-000"),
            "RG123"
        );

        // Act
        var age = patient.GetAge();

        // Assert
        var expectedAge = DateTime.Today.Year - dateOfBirth.Year;
        age.Should().Be(expectedAge);
    }

    [Fact]
    public void IsMinor_WhenAgeUnder18_ShouldReturnTrue()
    {
        // Arrange
        var dateOfBirth = DateTime.Today.AddYears(-16);
        var patient = Patient.Create(
            "Menor", "12345678901", dateOfBirth, 
            "menor@email.com", "(11) 98765-4321",
            Address.Create("Rua", "1", null, "Bairro", "Cidade", "SP", "00000-000"),
            "RG123"
        );

        // Act
        var isMinor = patient.IsMinor();

        // Assert
        isMinor.Should().BeTrue();
    }

    [Fact]
    public void AnonymizeData_ShouldClearPersonalInformation()
    {
        // Arrange
        var patient = Patient.Create(
            "João da Silva", "12345678901", new DateTime(1990, 5, 15),
            "joao@email.com", "(11) 98765-4321",
            Address.Create("Rua", "1", null, "Bairro", "Cidade", "SP", "00000-000"),
            "RG123"
        );

        // Act
        patient.AnonymizeData();

        // Assert
        patient.Name.Should().StartWith("Anônimo_");
        patient.EmailAddress.Value.Should().Be("anonymized@example.com");
        patient.Phone.Should().Be("0000000000");
        patient.ResponsibleName.Should().BeNull();
        patient.Status.Should().Be(PatientStatus.DataAnonymized);
    }
}
```

### 7.2. Teste de Serviço AuthService (com Mock)

Criar arquivo: `DentalClinic.Tests/UnitTests/Application/Services/AuthServiceTests.cs`

```csharp
using DentalClinic.Core.Application.DTOs;
using DentalClinic.Core.Application.Interfaces;
using DentalClinic.Core.Application.Services;
using DentalClinic.Core.Domain.Entities;
using DentalClinic.Core.Domain.Repositories;
using FluentAssertions;
using Microsoft.Extensions.Configuration;
using Moq;
using Xunit;

namespace DentalClinic.Tests.UnitTests.Application.Services;

public class AuthServiceTests
{
    private readonly Mock<IUserRepository> _userRepositoryMock;
    private readonly Mock<IUserSessionRepository> _sessionRepositoryMock;
    private readonly Mock<IPasswordHasher> _passwordHasherMock;
    private readonly Mock<ITokenService> _tokenServiceMock;
    private readonly Mock<IConfiguration> _configurationMock;
    private readonly AuthService _authService;

    public AuthServiceTests()
    {
        _userRepositoryMock = new Mock<IUserRepository>();
        _sessionRepositoryMock = new Mock<IUserSessionRepository>();
        _passwordHasherMock = new Mock<IPasswordHasher>();
        _tokenServiceMock = new Mock<ITokenService>();
        _configurationMock = new Mock<IConfiguration>();

        _configurationMock.Setup(c => c["Jwt:RefreshTokenExpirationDays"])
            .Returns("7");

        _authService = new AuthService(
            _userRepositoryMock.Object,
            _sessionRepositoryMock.Object,
            _passwordHasherMock.Object,
            _tokenServiceMock.Object,
            _configurationMock.Object
        );
    }

    [Fact]
    public async Task AuthenticateAsync_WithValidCredentials_ShouldReturnToken()
    {
        // Arrange
        var loginDto = new LoginDto { Email = "test@email.com", Password = "Senha123" };
        var user = User.Create(
            "Test User", "test@email.com", "Senha123", 
            UserRole.Admin, "00000000000"
        );

        _userRepositoryMock.Setup(r => r.GetByEmailAsync(loginDto.Email))
            .ReturnsAsync(user);

        _passwordHasherMock.Setup(h => h.VerifyPassword(loginDto.Password, user.PasswordHash))
            .Returns(true);

        _tokenServiceMock.Setup(t => t.GenerateAccessToken(user))
            .Returns("fake_access_token");

        _tokenServiceMock.Setup(t => t.GenerateRefreshToken())
            .Returns("fake_refresh_token");

        // Act
        var result = await _authService.AuthenticateAsync(loginDto);

        // Assert
        result.Success.Should().BeTrue();
        result.Data.AccessToken.Should().Be("fake_access_token");
        result.Data.RefreshToken.Should().Be("fake_refresh_token");
        
        _userRepositoryMock.Verify(r => r.UpdateAsync(user), Times.Once);
        _sessionRepositoryMock.Verify(r => r.AddAsync(It.IsAny<UserSession>()), Times.Once);
    }

    [Fact]
    public async Task AuthenticateAsync_WithInvalidPassword_ShouldReturnFailure()
    {
        // Arrange
        var loginDto = new LoginDto { Email = "test@email.com", Password = "SenhaErrada" };
        var user = User.Create(
            "Test User", "test@email.com", "Senha123", 
            UserRole.Admin, "00000000000"
        );

        _userRepositoryMock.Setup(r => r.GetByEmailAsync(loginDto.Email))
            .ReturnsAsync(user);

        _passwordHasherMock.Setup(h => h.VerifyPassword(loginDto.Password, user.PasswordHash))
            .Returns(false);

        // Act
        var result = await _authService.AuthenticateAsync(loginDto);

        // Assert
        result.Success.Should().BeFalse();
        result.Message.Should().Be("Credenciais inválidas.");
        
        _userRepositoryMock.Verify(r => r.UpdateAsync(user), Times.Once);
    }

    [Fact]
    public async Task AuthenticateAsync_WithInactiveUser_ShouldReturnFailure()
    {
        // Arrange
        var loginDto = new LoginDto { Email = "test@email.com", Password = "Senha123" };
        var user = User.Create(
            "Test User", "test@email.com", "Senha123", 
            UserRole.Admin, "00000000000"
        );
        user.Deactivate();

        _userRepositoryMock.Setup(r => r.GetByEmailAsync(loginDto.Email))
            .ReturnsAsync(user);

        // Act
        var result = await _authService.AuthenticateAsync(loginDto);

        // Assert
        result.Success.Should().BeFalse();
        result.Message.Should().Be("Usuário não encontrado ou inativo.");
    }
}
```

### 7.3. Teste de Repositório com Banco em Memória

Criar arquivo: `DentalClinic.Tests/UnitTests/Infrastructure/Repositories/PatientRepositoryTests.cs`

```csharp
using DentalClinic.Core.Domain.Entities;
using DentalClinic.Core.Domain.ValueObjects;
using DentalClinic.Infrastructure.Persistence;
using DentalClinic.Infrastructure.Persistence.Repositories;
using Microsoft.EntityFrameworkCore;
using FluentAssertions;
using Xunit;

namespace DentalClinic.Tests.UnitTests.Infrastructure.Repositories;

public class PatientRepositoryTests : IDisposable
{
    private readonly ApplicationDbContext _context;
    private readonly PatientRepository _repository;

    public PatientRepositoryTests()
    {
        // Configurar banco em memória
        var options = new DbContextOptionsBuilder<ApplicationDbContext>()
            .UseInMemoryDatabase(databaseName: $"TestDb_{Guid.NewGuid()}")
            .Options;

        _context = new ApplicationDbContext(options);
        _repository = new PatientRepository(_context);
    }

    [Fact]
    public async Task AddAsync_ShouldInsertPatient()
    {
        // Arrange
        var patient = Patient.Create(
            "João Teste", "12345678901", new DateTime(1990, 5, 15),
            "joao@test.com", "(11) 98765-4321",
            Address.Create("Rua Teste", "123", null, "Centro", "São Paulo", "SP", "01234-567"),
            "RG123"
        );

        // Act
        await _repository.AddAsync(patient);

        // Assert
        var savedPatient = await _context.Patients.FindAsync(patient.Id);
        savedPatient.Should().NotBeNull();
        savedPatient!.Name.Should().Be("João Teste");
    }

    [Fact]
    public async Task GetByIdAsync_ExistingPatient_ShouldReturnPatient()
    {
        // Arrange
        var patient = Patient.Create(
            "Maria Teste", "98765432100", new DateTime(1985, 10, 20),
            "maria@test.com", "(11) 12345-6789",
            Address.Create("Av. Principal", "456", "Sala 2", "Jardins", "São Paulo", "SP", "01452-000"),
            "RG987"
        );

        _context.Patients.Add(patient);
        await _context.SaveChangesAsync();

        // Act
        var result = await _repository.GetByIdAsync(patient.Id);

        // Assert
        result.Should().NotBeNull();
        result!.Name.Should().Be("Maria Teste");
    }

    [Fact]
    public async Task GetAllAsync_WithSearchTerm_ShouldFilterByName()
    {
        // Arrange
        var patient1 = Patient.Create(
            "João Silva", "11111111111", new DateTime(1990, 1, 1),
            "joao@test.com", "(11) 11111-1111",
            Address.Create("Rua A", "1", null, "Bairro A", "Cidade A", "SP", "00000-000"),
            "RG111"
        );

        var patient2 = Patient.Create(
            "Maria Santos", "22222222222", new DateTime(1992, 2, 2),
            "maria@test.com", "(11) 22222-2222",
            Address.Create("Rua B", "2", null, "Bairro B", "Cidade B", "SP", "00000-000"),
            "RG222"
        );

        _context.Patients.AddRange(patient1, patient2);
        await _context.SaveChangesAsync();

        // Act
        var result = await _repository.GetAllAsync(1, 10, "João");

        // Assert
        result.Should().HaveCount(1);
        result.First().Name.Should().Be("João Silva");
    }

    [Fact]
    public async Task AnonymizeAsync_ShouldClearPatientData()
    {
        // Arrange
        var patient = Patient.Create(
            "Pedro Teste", "33333333333", new DateTime(1988, 3, 15),
            "pedro@test.com", "(11) 33333-3333",
            Address.Create("Rua C", "3", null, "Bairro C", "Cidade C", "SP", "00000-000"),
            "RG333"
        );

        _context.Patients.Add(patient);
        await _context.SaveChangesAsync();

        // Act
        await _repository.AnonymizeAsync(patient.Id);

        // Assert
        var updatedPatient = await _repository.GetByIdAsync(patient.Id);
        updatedPatient!.Name.Should().StartWith("Anônimo_");
        updatedPatient.EmailAddress.Value.Should().Be("anonymized@example.com");
        updatedPatient.Status.Should().Be(PatientStatus.DataAnonymized);
    }

    public void Dispose()
    {
        _context.Dispose();
    }
}
```

### 7.4. Teste de Value Object CPF

Criar arquivo: `DentalClinic.Tests/UnitTests/Domain/ValueObjects/CpfTests.cs`

```csharp
using DentalClinic.Core.Domain.ValueObjects;
using FluentAssertions;
using Xunit;

namespace DentalClinic.Tests.UnitTests.Domain.ValueObjects;

public class CpfTests
{
    [Theory]
    [InlineData("12345678901")]  // CPF válido (ignora validação real para teste)
    [InlineData("111.222.333-44")]
    public void Create_WithValidFormat_ShouldCreateCpf(string cpfValue)
    {
        // Act
        var cpf = CPF.Create(cpfValue);

        // Assert
        cpf.Should().NotBeNull();
        cpf.Value.Should().MatchRegex(@"^\d{11}$");  // Apenas números
    }

    [Theory]
    [InlineData("")]
    [InlineData("123")]  // Muito curto
    [InlineData("123456789012")]  // Muito longo
    public void Create_WithInvalidFormat_ShouldThrowException(string invalidCpf)
    {
        // Act & Assert
        var act = () => CPF.Create(invalidCpf);
        act.Should().Throw<ArgumentException>()
            .WithMessage("*CPF*");
    }
}
```

### 7.5. Executar Testes Unitários

```bash
cd /workspace/backend/DentalClinic.Tests

# Executar todos os testes
dotnet test

# Executar com detalhes
dotnet test --verbosity normal

# Executar apenas testes de uma classe
dotnet test --filter "FullyQualifiedName~PatientTests"

# Gerar relatório de cobertura
dotnet test --collect:"XPlat Code Coverage"

# Ver resultados
cat TestResults/*/coverage.cobertura.xml | head -50
```

---

## 8. Testes de Integração

### 8.1. Configurar WebApplicationFactory

Criar arquivo: `DentalClinic.Tests/IntegrationTests/Controllers/AuthControllerTests.cs`

```csharp
using DentalClinic.Core.Domain.Entities;
using DentalClinic.Infrastructure.Persistence;
using FluentAssertions;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using System.Net;
using System.Net.Http.Json;
using System.Text;
using System.Text.Json;
using Xunit;

namespace DentalClinic.Tests.IntegrationTests.Controllers;

public class AuthControllerTests : IClassFixture<CustomWebApplicationFactory>
{
    private readonly HttpClient _client;
    private readonly CustomWebApplicationFactory _factory;

    public AuthControllerTests(CustomWebApplicationFactory factory)
    {
        _factory = factory;
        _client = factory.CreateClient();
    }

    [Fact]
    public async Task Login_WithValidCredentials_ShouldReturnToken()
    {
        // Arrange
        var loginData = new
        {
            email = "admin@odonto.com",
            password = "Admin@123"
        };

        var content = new StringContent(
            JsonSerializer.Serialize(loginData),
            Encoding.UTF8,
            "application/json"
        );

        // Act
        var response = await _client.PostAsync("/api/Auth/login", content);

        // Assert
        response.StatusCode.Should().Be(HttpStatusCode.OK);
        
        var responseBody = await response.Content.ReadFromJsonAsync<JsonElement>();
        responseBody.GetProperty("accessToken").GetString().Should().NotBeNullOrEmpty();
        responseBody.GetProperty("refreshToken").GetString().Should().NotBeNullOrEmpty();
    }

    [Fact]
    public async Task Login_WithInvalidCredentials_ShouldReturnUnauthorized()
    {
        // Arrange
        var loginData = new
        {
            email = "admin@odonto.com",
            password = "SenhaErrada"
        };

        var content = new StringContent(
            JsonSerializer.Serialize(loginData),
            Encoding.UTF8,
            "application/json"
        );

        // Act
        var response = await _client.PostAsync("/api/Auth/login", content);

        // Assert
        response.StatusCode.Should().Be(HttpStatusCode.Unauthorized);
    }
}

/// <summary>
/// Factory personalizada para configurar o ambiente de teste
/// </summary>
public class CustomWebApplicationFactory : WebApplicationFactory<Program>
{
    protected override void ConfigureWebHost(IWebHostBuilder builder)
    {
        builder.ConfigureServices(services =>
        {
            // Remover DbContext real
            var descriptor = services.SingleOrDefault(
                d => d.ServiceType == typeof(DbContextOptions<ApplicationDbContext>)
            );

            if (descriptor != null)
            {
                services.Remove(descriptor);
            }

            // Adicionar DbContext em memória
            services.AddDbContext<ApplicationDbContext>(options =>
            {
                options.UseInMemoryDatabase($"InMemoryDbForTesting_{Guid.NewGuid()}");
            });

            // Seed inicial de dados
            using var scope = services.BuildServiceProvider().CreateScope();
            var context = scope.ServiceProvider.GetRequiredService<ApplicationDbContext>();
            SeedDatabase(context);
        });
    }

    private void SeedDatabase(ApplicationDbContext context)
    {
        // Criar usuário admin para testes
        var admin = User.Create(
            "Administrador",
            "admin@odonto.com",
            "Admin@123",
            UserRole.Admin,
            "00000000000"
        );

        context.Users.Add(admin);
        context.SaveChanges();
    }
}
```

### 8.2. Teste de Integração - PatientsController

Criar arquivo: `DentalClinic.Tests/IntegrationTests/Controllers/PatientsControllerTests.cs`

```csharp
using DentalClinic.Core.Domain.Entities;
using DentalClinic.Core.Domain.ValueObjects;
using FluentAssertions;
using Microsoft.AspNetCore.Mvc.Testing;
using System.Net;
using System.Net.Http.Json;
using System.Text;
using System.Text.Json;
using Xunit;

namespace DentalClinic.Tests.IntegrationTests.Controllers;

public class PatientsControllerTests : IClassFixture<CustomWebApplicationFactory>
{
    private readonly HttpClient _client;
    private readonly string _authToken;

    public PatientsControllerTests(CustomWebApplicationFactory factory)
    {
        _client = factory.CreateClient();
        _authToken = GetAuthToken();
    }

    private string GetAuthToken()
    {
        // Simular login e pegar token
        // Em produção, implementar método auxiliar
        return "fake_token_for_testing";
    }

    [Fact]
    public async Task CreatePatient_WithValidData_ShouldReturnCreated()
    {
        // Arrange
        _client.DefaultRequestHeaders.Authorization = 
            new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", _authToken);

        var patientData = new
        {
            name = "Paciente Teste",
            cpf = "12345678901",
            dateOfBirth = "1990-05-15",
            email = "paciente@test.com",
            phone = "(11) 98765-4321",
            address = new
            {
                street = "Rua Teste",
                number = "123",
                complement = "",
                neighborhood = "Centro",
                city = "São Paulo",
                state = "SP",
                zipCode = "01234-567"
            },
            documentNumber = "RG123456"
        };

        var content = new StringContent(
            JsonSerializer.Serialize(patientData),
            Encoding.UTF8,
            "application/json"
        );

        // Act
        var response = await _client.PostAsync("/api/Patients", content);

        // Assert
        response.StatusCode.Should().Be(HttpStatusCode.Created);
        
        var createdPatient = await response.Content.ReadFromJsonAsync<JsonElement>();
        createdPatient.GetProperty("name").GetString().Should().Be("Paciente Teste");
    }

    [Fact]
    public async Task GetPatients_WithoutAuthentication_ShouldReturnUnauthorized()
    {
        // Act
        var response = await _client.GetAsync("/api/Patients");

        // Assert
        response.StatusCode.Should().Be(HttpStatusCode.Unauthorized);
    }
}
```

### 8.3. Executar Testes de Integração

```bash
cd /workspace/backend/DentalClinic.Tests

# Executar apenas testes de integração
dotnet test --filter "FullyQualifiedName~IntegrationTests"

# Executar todos os testes (unitários + integração)
dotnet test --logger "console;verbosity=detailed"

# Gerar relatório HTML (requer pacote ReportGenerator)
dotnet test /p:CollectCoverage=true /p:CoverletOutputFormat=cobertura
reportgenerator -reports:coverage.cobertura.xml -targetdir:coveragereport
```

---

## 9. Testes de Performance

### 9.1. Instalar k6

```bash
# Ubuntu/Debian
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C5AD17C747E3415A3642D57D77C6C491D6AC1D69
echo "deb https://dl.k6.io/deb stable main" | sudo tee /etc/apt/sources.list.d/k6.list
sudo apt-get update
sudo apt-get install k6

# Ou via Homebrew (Mac)
brew install k6
```

### 9.2. Script de Teste de Performance

Criar arquivo: `backend/tests/performance/load_test.js`

```javascript
import http from 'k6/http';
import { check, sleep } from 'k6';
import { Rate } from 'k6/metrics';

// Métrica customizada para erros de autenticação
const errorRate = new Rate('errors');

export const options = {
  stages: [
    { duration: '30s', target: 10 },   // Ramp up para 10 usuários
    { duration: '1m', target: 10 },    // Manter 10 usuários por 1 minuto
    { duration: '30s', target: 50 },   // Ramp up para 50 usuários
    { duration: '2m', target: 50 },    // Manter 50 usuários por 2 minutos
    { duration: '30s', target: 0 },    // Ramp down
  ],
  thresholds: {
    http_req_duration: ['p(95)<500'],  // 95% das requisições devem ser < 500ms
    errors: ['rate<0.1'],              // Menos de 10% de erros
  },
};

const BASE_URL = 'http://localhost:5000';

// Credenciais de teste
const credentials = {
  email: 'admin@odonto.com',
  password: 'Admin@123'
};

export function setup() {
  // Fazer login uma vez e reutilizar token
  const loginResponse = http.post(`${BASE_URL}/api/Auth/login`, JSON.stringify(credentials), {
    headers: { 'Content-Type': 'application/json' },
  });

  check(loginResponse, {
    'login status is 200': (r) => r.status === 200,
  });

  const token = loginResponse.json('accessToken');
  return { token };
}

export default function (data) {
  const { token } = data;
  
  const params = {
    headers: {
      'Authorization': `Bearer ${token}`,
      'Content-Type': 'application/json',
    },
  };

  // Testar listagem de pacientes
  const patientsResponse = http.get(`${BASE_URL}/api/Patients?page=1&pageSize=10`, params);
  
  check(patientsResponse, {
    'patients status is 200': (r) => r.status === 200,
    'patients load time < 200ms': (r) => r.timings.duration < 200,
  });

  errorRate.add(patientsResponse.status !== 200);

  sleep(1);
}
```

### 9.3. Executar Teste de Performance

```bash
cd /workspace/backend/tests/performance

# Executar teste de carga
k6 run load_test.js

# Executar com mais detalhes
k6 run --verbose load_test.js

# Exportar resultados para JSON
k6 run --out json=results.json load_test.js

# Analisar resultados
cat results.json | jq '.data.metric' | head -20
```

---

## 10. Checklist de Validação Completo

### 10.1. Checklist de Infraestrutura

- [ ] PostgreSQL instalado e rodando
- [ ] Banco de dados `odonto_clinica` criado
- [ ] Connection String configurada corretamente
- [ ] .NET SDK 9.0 instalado
- [ ] Todas as dependências restauradas (`dotnet restore`)
- [ ] Build bem-sucedido (`dotnet build`)
- [ ] Migrações aplicadas (`dotnet ef database update`)

### 10.2. Checklist de Funcionalidades

#### Autenticação e Autorização
- [ ] Login retorna access token e refresh token
- [ ] Token JWT tem expiração correta (60 minutos)
- [ ] Refresh token funciona após expiração do access token
- [ ] Logout invalida sessão
- [ ] Usuário inativo não consegue login
- [ ] Senha incorreta retorna erro apropriado
- [ ] Roles (Admin, Dentista, Recepcionista) são respeitadas

#### Gestão de Pacientes
- [ ] CRUD de pacientes completo
- [ ] Paginação funciona corretamente
- [ ] Busca por nome/CPF funciona
- [ ] Validações de CPF, email, telefone funcionam
- [ ] Anonimização LGPD funciona (apenas Admin)
- [ ] Paciente menor de idade identifica responsável

#### Agenda
- [ ] Criar agendamento valida conflitos de horário
- [ ] Listar agendamentos por profissional/data
- [ ] Cancelar agendamento notifica paciente
- [ ] Status do agendamento é atualizado corretamente

#### Prontuário Eletrônico
- [ ] Criar prontuário vincula ao paciente
- [ ] Odontograma é persistido corretamente
- [ ] Histórico de evoluções é mantido
- [ ] Apenas profissionais autorizados acessam
- [ ] Auditoria LGPD registra acessos

#### SignalR (Tempo Real)
- [ ] Conexão ao hub é estabelecida
- [ ] Grupos de pacientes são criados
- [ ] Notificações em tempo real chegam ao cliente
- [ ] Desconexão limpa grupos corretamente

### 10.3. Checklist de Segurança

- [ ] Senhas são hasheadas com BCrypt
- [ ] JWT usa chave secreta forte (>32 caracteres)
- [ ] HTTPS forçado em produção
- [ ] CORS configurado apenas para origens permitidas
- [ ] Stack trace não é exposto em produção
- [ ] Logs de auditoria registram acessos a dados sensíveis
- [ ] SQL Injection prevenido (EF Core parametriza queries)
- [ ] Rate limiting implementado (se aplicável)

### 10.4. Checklist de Testes

- [ ] Todos os testes unitários passam (`dotnet test`)
- [ ] Cobertura de código > 80%
- [ ] Testes de integração passam
- [ ] Testes de performance atendem SLAs (< 500ms P95)
- [ ] Nenhum warning crítico no build
- [ ] Análise estática do código (SonarQube, se disponível)

### 10.5. Checklist de Documentação

- [ ] Swagger文档 atualizado
- [ ] Endpoints documentados com exemplos
- [ ] Schemas de DTOs claros
- [ ] Mensagens de erro em português
- [ ] README com instruções de setup

---

## 11. Troubleshooting

### 11.1. Erro: "The Npgsql connection failed"

**Causa:** PostgreSQL não está rodando ou connection string incorreta.

**Solução:**
```bash
# Verificar se container está rodando
docker ps | grep odonto-postgres

# Se não estiver, iniciar
docker start odonto-postgres

# Verificar logs do container
docker logs odonto-postgres

# Testar conexão manual
psql -h localhost -U postgres -d odonto_clinica
```

### 11.2. Erro: "JWT Key not configured"

**Causa:** Chave JWT não definida no appsettings.json.

**Solução:**
```bash
# Editar appsettings.json
cat /workspace/backend/DentalClinic.Api/appsettings.json | grep -A 5 "Jwt"

# Garantir que Key tem pelo menos 32 caracteres
# Exemplo válido: "MinhaChaveSuperSecretaComMaisDe32CaracteresAqui!"
```

### 11.3. Erro: "Migration 'X' was not found"

**Causa:** Migrações não foram geradas ou estão desatualizadas.

**Solução:**
```bash
cd /workspace/backend/DentalClinic.Api

# Listar migrações existentes
dotnet ef migrations list

# Se vazia, gerar nova migração
dotnet ef migrations add InitialCreate

# Aplicar ao banco
dotnet ef database update
```

### 11.4. Erro: "Port 5000 already in use"

**Causa:** Outra aplicação está usando a porta 5000.

**Solução:**
```bash
# Matar processo na porta 5000
lsof -ti:5000 | xargs kill -9

# Ou mudar a porta da API
dotnet run --urls "http://localhost:5001"
```

### 11.5. Erro: "Testes falham com 'Database does not exist'"

**Causa:** Banco de dados de teste não foi criado.

**Solução:**
```bash
# Para testes em memória, garantir que UseInMemoryDatabase está configurado
# No teste:
var options = new DbContextOptionsBuilder<ApplicationDbContext>()
    .UseInMemoryDatabase($"TestDb_{Guid.NewGuid()}")
    .Options;
```

### 11.6. Erro: "CORS policy failed"

**Causa:** Frontend tentando acessar de origem não permitida.

**Solução:**
```csharp
// Em Program.cs, ajustar política CORS
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowFlutter",
        policy => policy.WithOrigins("http://localhost:3000", "http://localhost:50000")
                        .AllowAnyMethod()
                        .AllowAnyHeader()
                        .AllowCredentials());
});
```

### 11.7. Performance Lenta

**Causa:** Queries sem índice ou N+1 queries.

**Solução:**
```bash
# Habilitar logging de queries no appsettings.json
{
  "Logging": {
    "LogLevel": {
      "Microsoft.EntityFrameworkCore.Database.Command": "Information"
    }
  }
}

# Verificar queries lentas nos logs
# Adicionar índices no banco:
docker exec -it odonto-postgres psql -U postgres -d odonto_clinica <<EOF
CREATE INDEX IF NOT EXISTS idx_patients_name ON "Patients" ("Name");
CREATE INDEX IF NOT EXISTS idx_appointments_date ON "Appointments" ("StartTime");
EOF
```

---

## 📊 Resumo Final

### Comandos Úteis

```bash
# Build e teste rápido
cd /workspace/backend
dotnet build && dotnet test

# Rodar API em development
dotnet run --project DentalClinic.Api --configuration Development

# Limpar e reconstruir
dotnet clean && dotnet restore && dotnet build

# Verificar saúde do banco
docker exec -it odonto-postgres psql -U postgres -d odonto_clinica -c "SELECT COUNT(*) FROM \"Patients\";"

# Backup do banco
docker exec odonto-postgres pg_dump -U postgres odonto_clinica > backup.sql

# Restore do banco
docker exec -i odonto-postgres psql -U postgres odonto_clinica < backup.sql
```

### Métricas de Qualidade Alvo

| Métrica | Meta | Como Medir |
|---------|------|------------|
| Cobertura de Testes | > 80% | `dotnet test /p:CollectCoverage=true` |
| Tempo de Resposta (P95) | < 500ms | k6 ou Application Insights |
| Taxa de Erros | < 1% | Logs + Monitoramento |
| Disponibilidade | > 99.5% | Uptime monitoring |
| Débito Técnico | < 5% | SonarQube analysis |

---

**🎉 Parabéns!** Você completou o guia completo de testagem do backend da OdontoClinica Universitária.

Para dúvidas ou problemas, consulte a seção de [Troubleshooting](#11-troubleshooting) ou abra uma issue no repositório do projeto.
