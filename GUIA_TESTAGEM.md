# 🧪 GUIA COMPLETO DE TESTAGEM - OdontoClinica Universitária

Este documento fornece um passo a passo detalhado para testar o **Frontend (Flutter)** e o **Backend (ASP.NET Core 9)** do sistema.

---

## 📋 ÍNDICE

1. [Pré-requisitos](#1-pré-requisitos)
2. [Testagem do Backend](#2-testagem-do-backend)
3. [Testagem do Frontend](#3-testagem-do-frontend)
4. [Testes de Integração](#4-testes-de-integração)
5. [Checklist de Validação](#5-checklist-de-validação)

---

## 1. PRÉ-REQUISITOS

### 1.1 Ferramentas Necessárias

```bash
# Verificar versões instaladas
dotnet --version           # Deve ser 9.0+
flutter --version          # Deve ser 3.24+
psql --version             # Deve ser 15+
docker --version           # Opcional (para PostgreSQL em container)
```

### 1.2 Estrutura do Projeto

```
/workspace
├── backend/
│   ├── DentalClinic.Api/          # API REST + SignalR
│   ├── DentalClinic.Core/         # Domain + Application
│   └── DentalClinic.Infrastructure/# Persistence + Security
├── lib/                           # Código Flutter
├── test/                          # Testes Flutter
└── pubspec.yaml                   # Dependências Flutter
```

---

## 2. TESTAGEM DO BACKEND

### 2.1 Configuração Inicial

#### Passo 1: Configurar Banco de Dados

**Opção A - PostgreSQL Local:**
```bash
# Acessar PostgreSQL
psql -U postgres

# Criar database
CREATE DATABASE odonto_clinica;

# Criar usuário (opcional)
CREATE USER odonto_user WITH ENCRYPTED PASSWORD 'odonto_password';
GRANT ALL PRIVILEGES ON DATABASE odonto_clinica TO odonto_user;

# Sair
\q
```

**Opção B - Docker (Recomendado para testes):**
```bash
docker run --name odonto-postgres \
  -e POSTGRES_DB=odonto_clinica \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=postgres \
  -p 5432:5432 \
  -d postgres:15
```

#### Passo 2: Configurar Connection String

Editar `backend/DentalClinic.Api/appsettings.json`:

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

#### Passo 3: Restaurar Dependências

```bash
cd /workspace/backend

# Restaurar pacotes
dotnet restore

# Verificar se há erros
dotnet build
```

### 2.2 Executar Migrações

```bash
cd /workspace/backend/DentalClinic.Api

# Aplicar migrações ao banco
dotnet ef database update

# Verificar tabelas criadas
psql -U postgres -d odonto_clinica -c "\dt"
```

**Tabelas esperadas:**
- Users
- Patients
- Appointments
- Prontuarios
- TreatmentPlans
- UserSessions
- Notifications
- Anexos
- WaitLists
- LogsAuditoria
- Clinics
- Procedures
- Evolutions
- Anamneses
- Odontograms
- Prescriptions
- MedicalCertificates
- ReportExecutions

### 2.3 Rodar a API

```bash
cd /workspace/backend/DentalClinic.Api

# Modo Development (com Swagger)
dotnet run --configuration Development

# Ou modo Release
dotnet run --configuration Release
```

**Endpoints de acesso:**
- **Swagger UI**: `https://localhost:5001/swagger` ou `http://localhost:5000/swagger`
- **Health Check**: `https://localhost:5001/health`
- **SignalR Hub**: `https://localhost:5001/hubs/clinic`

### 2.4 Testes Unitários do Backend

#### Criar Projeto de Testes (se não existir)

```bash
cd /workspace/backend

# Criar projeto de testes
dotnet new xunit -n DentalClinic.Tests

# Adicionar referências
dotnet add DentalClinic.Tests/DentalClinic.Tests.csproj reference DentalClinic.Core/DentalClinic.Core.csproj
dotnet add DentalClinic.Tests/DentalClinic.Tests.csproj reference DentalClinic.Infrastructure/DentalClinic.Infrastructure.csproj

# Adicionar pacotes de teste
cd DentalClinic.Tests
dotnet add package Moq
dotnet add package FluentAssertions
dotnet add package Microsoft.EntityFrameworkCore.InMemory
```

#### Exemplo de Teste Unitário - AuthService

Criar arquivo `backend/DentalClinic.Tests/AuthServiceTests.cs`:

```csharp
using Xunit;
using FluentAssertions;
using Moq;
using DentalClinic.Core.Application.Services;
using DentalClinic.Core.Domain.Repositories;
using DentalClinic.Core.Application.Interfaces;
using DentalClinic.Core.Application.DTOs;

namespace DentalClinic.Tests;

public class AuthServiceTests
{
    private readonly Mock<IUserRepository> _userRepositoryMock;
    private readonly Mock<IPasswordHasher> _passwordHasherMock;
    private readonly Mock<ITokenService> _tokenServiceMock;
    private readonly AuthService _authService;

    public AuthServiceTests()
    {
        _userRepositoryMock = new Mock<IUserRepository>();
        _passwordHasherMock = new Mock<IPasswordHasher>();
        _tokenServiceMock = new Mock<ITokenService>();
        
        _authService = new AuthService(
            _userRepositoryMock.Object,
            _passwordHasherMock.Object,
            _tokenServiceMock.Object,
            Mock.Of<ILogger<AuthService>>()
        );
    }

    [Fact]
    public async Task AuthenticateAsync_ValidCredentials_ReturnsSuccess()
    {
        // Arrange
        var loginDto = new LoginDto { Email = "admin@clinica.com", Password = "Senha123!" };
        var user = new User { Id = 1, Email = "admin@clinica.com", PasswordHash = "hashed_password" };
        
        _userRepositoryMock.Setup(r => r.GetByEmailAsync(loginDto.Email))
            .ReturnsAsync(user);
        _passwordHasherMock.Setup(p => p.Verify(loginDto.Password, user.PasswordHash))
            .Returns(true);
        _tokenServiceMock.Setup(t => t.GenerateToken(user))
            .Returns("fake_token");

        // Act
        var result = await _authService.AuthenticateAsync(loginDto);

        // Assert
        result.Success.Should().BeTrue();
        result.Data.AccessToken.Should().NotBeNullOrEmpty();
    }

    [Fact]
    public async Task AuthenticateAsync_InvalidCredentials_ReturnsFailure()
    {
        // Arrange
        var loginDto = new LoginDto { Email = "invalid@email.com", Password = "WrongPassword" };
        _userRepositoryMock.Setup(r => r.GetByEmailAsync(loginDto.Email))
            .ReturnsAsync((User)null);

        // Act
        var result = await _authService.AuthenticateAsync(loginDto);

        // Assert
        result.Success.Should().BeFalse();
        result.Message.Should().Contain("inválidos");
    }
}
```

#### Executar Testes

```bash
cd /workspace/backend/DentalClinic.Tests

# Rodar todos os testes
dotnet test

# Rodar com detalhes
dotnet test --logger "console;verbosity=detailed"

# Gerar relatório de cobertura (requer dotnet-coverage)
dotnet test /p:CollectCoverage=true /p:CoverletOutputFormat=cobertura
```

### 2.5 Testes de Integração da API

#### Criar Teste de Integração - AuthController

Criar arquivo `backend/DentalClinic.Tests/Integration/AuthControllerTests.cs`:

```csharp
using Xunit;
using Microsoft.AspNetCore.Mvc.Testing;
using System.Net.Http;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

namespace DentalClinic.Tests.Integration;

public class AuthControllerTests : IClassFixture<WebApplicationFactory<Program>>
{
    private readonly HttpClient _client;

    public AuthControllerTests(WebApplicationFactory<Program> factory)
    {
        _client = factory.CreateClient();
    }

    [Fact]
    public async Task Post_Login_ReturnsSuccess()
    {
        // Arrange
        var loginData = new { email = "admin@clinica.com", password = "Admin123!" };
        var content = new StringContent(
            JsonSerializer.Serialize(loginData),
            Encoding.UTF8,
            "application/json"
        );

        // Act
        var response = await _client.PostAsync("/api/auth/login", content);

        // Assert
        response.StatusCode.Should().Be(HttpStatusCode.OK);
        var responseBody = await response.Content.ReadAsStringAsync();
        responseBody.Should().Contain("accessToken");
    }

    [Fact]
    public async Task Post_Login_InvalidCredentials_ReturnsUnauthorized()
    {
        // Arrange
        var loginData = new { email = "invalid@email.com", password = "WrongPassword" };
        var content = new StringContent(
            JsonSerializer.Serialize(loginData),
            Encoding.UTF8,
            "application/json"
        );

        // Act
        var response = await _client.PostAsync("/api/auth/login", content);

        // Assert
        response.StatusCode.Should().Be(HttpStatusCode.Unauthorized);
    }
}
```

### 2.6 Testes Manuais via Swagger

#### Fluxo de Teste - Autenticação

1. **Acessar Swagger**: `http://localhost:5000/swagger`

2. **Testar Login**:
   - Endpoint: `POST /api/Auth/login`
   - Body:
   ```json
   {
     "email": "admin@clinica.com",
     "password": "Admin123!"
   }
   ```
   - **Resultado Esperado**: Status 200 OK com `accessToken` e `refreshToken`

3. **Testar Refresh Token**:
   - Endpoint: `POST /api/Auth/refresh`
   - Body:
   ```json
   {
     "refreshToken": "{token_obtido_no_login}"
   }
   ```
   - **Resultado Esperado**: Status 200 OK com novo `accessToken`

4. **Testar Logout**:
   - Endpoint: `POST /api/Auth/logout`
   - Header: `Authorization: Bearer {access_token}`
   - **Resultado Esperado**: Status 204 No Content

#### Fluxo de Teste - Pacientes

1. **Listar Pacientes**:
   - Endpoint: `GET /api/Patients?page=1&pageSize=10`
   - Header: `Authorization: Bearer {access_token}`
   - **Resultado Esperado**: Status 200 OK com lista de pacientes

2. **Criar Paciente**:
   - Endpoint: `POST /api/Patients`
   - Header: `Authorization: Bearer {access_token}`
   - Body:
   ```json
   {
     "name": "João da Silva",
     "cpf": "123.456.789-00",
     "email": "joao@email.com",
     "phone": "(11) 99999-9999",
     "birthDate": "1990-01-15"
   }
   ```
   - **Resultado Esperado**: Status 201 Created

3. **Buscar Paciente por ID**:
   - Endpoint: `GET /api/Patients/{id}`
   - Header: `Authorization: Bearer {access_token}`
   - **Resultado Esperado**: Status 200 OK com dados do paciente

4. **Atualizar Paciente**:
   - Endpoint: `PUT /api/Patients/{id}`
   - Header: `Authorization: Bearer {access_token}`
   - Body: Dados atualizados
   - **Resultado Esperado**: Status 200 OK

5. **Deletar Paciente (Soft Delete)**:
   - Endpoint: `DELETE /api/Patients/{id}`
   - Header: `Authorization: Bearer {access_token}`
   - **Resultado Esperado**: Status 204 No Content

#### Fluxo de Teste - Agendamentos

1. **Criar Agendamento**:
   - Endpoint: `POST /api/Appointments`
   - Body:
   ```json
   {
     "patientId": 1,
     "professionalId": 1,
     "startTime": "2026-07-20T14:00:00",
     "endTime": "2026-07-20T15:00:00",
     "procedureId": 1,
     "clinicId": 1
   }
   ```
   - **Resultado Esperado**: Status 201 Created

2. **Verificar Conflito**:
   - Tentar criar agendamento no mesmo horário
   - **Resultado Esperado**: Status 400 Bad Request com mensagem de conflito

3. **Confirmar Agendamento**:
   - Endpoint: `PUT /api/Appointments/{id}/confirm`
   - **Resultado Esperado**: Status 200 OK

4. **Cancelar Agendamento**:
   - Endpoint: `PUT /api/Appointments/{id}/cancel`
   - Body: `{ "reason": "Motivo do cancelamento" }`
   - **Resultado Esperado**: Status 200 OK

### 2.7 Testes de Carga (Opcional)

#### Usando k6

```bash
# Instalar k6
sudo apt-get install k6  # Linux
brew install k6          # macOS

# Criar script de teste
cat > load_test.js << EOF
import http from 'k6/http';
import { check, sleep } from 'k6';

export let options = {
  stages: [
    { duration: '30s', target: 20 },
    { duration: '1m30s', target: 100 },
    { duration: '20s', target: 0 },
  ],
};

export default function () {
  let res = http.get('http://localhost:5000/api/patients', {
    headers: { 'Authorization': 'Bearer YOUR_TOKEN' },
  });
  
  check(res, {
    'status was 200': (r) => r.status == 200,
    'response time < 200ms': (r) => r.timings.duration < 200,
  });
  
  sleep(1);
}
EOF

# Executar teste
k6 run load_test.js
```

---

## 3. TESTAGEM DO FRONTEND

### 3.1 Configuração Inicial

#### Passo 1: Instalar Dependências

```bash
cd /workspace

# Obter dependências
flutter pub get

# Ativar ferramentas de build
dart pub global activate build_runner
```

#### Passo 2: Gerar Código Automático

```bash
cd /workspace

# Gerar arquivos Freezed, JsonSerializable, Riverpod
flutter pub run build_runner build --delete-conflicting-outputs

# Ou em modo watch (durante desenvolvimento)
flutter pub run build_runner watch --delete-conflicting-outputs
```

#### Passo 3: Configurar Ambiente

Criar arquivo `lib/core/config/env_config.dart`:

```dart
class EnvConfig {
  static const String apiBaseUrl = 'http://localhost:5000';
  static const String apiVersion = '/api/v1';
  static const Duration requestTimeout = Duration(seconds: 30);
  static const bool debugMode = true;
}
```

### 3.2 Análise Estática de Código

```bash
cd /workspace

# Analisar código em busca de erros e warnings
flutter analyze

# Formatar código
dart format .

# Verificar dependências desatualizadas
flutter pub outdated
```

### 3.3 Testes Unitários

#### Criar Teste Unitário - ViewModel de Login

Criar arquivo `test/features/auth/viewmodels/login_viewmodel_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promt/features/auth/presentation/viewmodels/login_viewmodel.dart';
import 'package:promt/features/auth/domain/repositories/auth_repository.dart';

@GenerateMocks([AuthRepository])
import 'login_viewmodel_test.mocks.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late ProviderContainer container;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(mockAuthRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('LoginViewModel deve autenticar com credenciais válidas', () async {
    // Arrange
    when(mockAuthRepository.login(any, any))
        .thenAnswer((_) async => Right(TokenModel(
          accessToken: 'fake_token',
          refreshToken: 'fake_refresh',
        )));

    final viewModel = container.read(loginViewModelProvider.notifier);
    
    // Act
    await viewModel.login('admin@clinica.com', 'Admin123!');

    // Assert
    verify(mockAuthRepository.login('admin@clinica.com', 'Admin123!')).called(1);
    expect(viewModel.state.isLoading, false);
    expect(viewModel.state.isSuccess, true);
  });

  test('LoginViewModel deve falhar com credenciais inválidas', () async {
    // Arrange
    when(mockAuthRepository.login(any, any))
        .thenAnswer((_) async => Left('Credenciais inválidas'));

    final viewModel = container.read(loginViewModelProvider.notifier);
    
    // Act
    await viewModel.login('invalid@email.com', 'WrongPassword');

    // Assert
    expect(viewModel.state.isLoading, false);
    expect(viewModel.state.isError, true);
    expect(viewModel.state.errorMessage, 'Credenciais inválidas');
  });
}
```

#### Gerar Mocks

```bash
cd /workspace

# Gerar arquivos de mock
flutter pub run build_runner build --delete-conflicting-outputs
```

#### Executar Testes Unitários

```bash
cd /workspace

# Rodar todos os testes
flutter test

# Rodar testes com cobertura
flutter test --coverage

# Visualizar cobertura (gera HTML)
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html  # macOS
xdg-open coverage/html/index.html  # Linux
```

### 3.4 Testes de Widgets

#### Criar Teste de Widget - LoginPage

Criar arquivo `test/features/auth/views/login_page_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promt/features/auth/presentation/views/login_page.dart';

void main() {
  testWidgets('LoginPage deve exibir campos de email e senha', (tester) async {
    // Arrange
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: LoginPage()),
      ),
    );

    // Assert
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Senha'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('LoginPage deve validar email vazio', (tester) async {
    // Arrange
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: LoginPage()),
      ),
    );

    // Act
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Assert
    expect(find.text('Email é obrigatório'), findsOneWidget);
  });

  testWidgets('LoginPage deve validar senha vazia', (tester) async {
    // Arrange
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: LoginPage()),
      ),
    );

    // Act - Preencher apenas email
    await tester.enterText(
      find.byType(TextFormField).first,
      'admin@clinica.com',
    );
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Assert
    expect(find.text('Senha é obrigatória'), findsOneWidget);
  });

  testWidgets('LoginPage deve submeter formulário válido', (tester) async {
    // Arrange
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: LoginPage()),
      ),
    );

    // Act - Preencher formulário
    await tester.enterText(
      find.byType(TextFormField).first,
      'admin@clinica.com',
    );
    await tester.enterText(
      find.byType(TextFormField).last,
      'Admin123!',
    );
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Assert
    // Verificar navegação ou estado de loading
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
```

### 3.5 Testes de Integração

#### Criar Teste de Integração - Fluxo Completo de Login

Criar arquivo `test/integration/auth_flow_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:promt/main.dart';
import 'package:promt/features/auth/presentation/views/login_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Fluxo de Autenticação', () {
    testWidgets('Deve realizar login com sucesso', (tester) async {
      // Arrange
      await tester.pumpWidget(const OdontoClinicaApp());
      await tester.pumpAndSettle();

      // Act - Preencher credenciais
      await tester.enterText(
        find.byKey(const Key('email_field')),
        'admin@clinica.com',
      );
      await tester.enterText(
        find.byKey(const Key('password_field')),
        'Admin123!',
      );
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle();

      // Assert - Verificar navegação para Dashboard
      expect(find.byType(DashboardPage), findsOneWidget);
    });

    testWidgets('Deve exibir erro com credenciais inválidas', (tester) async {
      // Arrange
      await tester.pumpWidget(const OdontoClinicaApp());
      await tester.pumpAndSettle();

      // Act - Preencher credenciais inválidas
      await tester.enterText(
        find.byKey(const Key('email_field')),
        'invalid@email.com',
      );
      await tester.enterText(
        find.byKey(const Key('password_field')),
        'WrongPassword',
      );
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle();

      // Assert - Verificar mensagem de erro
      expect(find.text('Credenciais inválidas'), findsOneWidget);
    });
  });
}
```

#### Executar Testes de Integração

```bash
cd /workspace

# Para dispositivo móvel
flutter test integration_test/auth_flow_test.dart

# Para web
flutter test -d chrome integration_test/auth_flow_test.dart
```

### 3.6 Testes Manuais no Emulador/Dispositivo

#### Passo 1: Iniciar Emulador

```bash
# Listar dispositivos disponíveis
flutter devices

# Iniciar emulador Android
flutter emulators --launch <emulator_id>

# Ou abrir iOS Simulator
open -a Simulator  # macOS
```

#### Passo 2: Rodar Aplicação

```bash
cd /workspace

# Rodar em modo debug
flutter run

# Rodar em modo release
flutter run --release

# Rodar com hot reload
flutter run --hot

# Especificar dispositivo
flutter run -d <device_id>
```

#### Passo 3: Checklist de Testes Manuais

**Tela de Login:**
- [ ] Campos de email e senha visíveis
- [ ] Validação de email vazio
- [ ] Validação de senha vazia
- [ ] Validação de formato de email
- [ ] Botão de login habilitado/desabilitado conforme preenchimento
- [ ] Link "Esqueci minha senha" (se houver)
- [ ] Loading durante autenticação
- [ ] Mensagem de erro para credenciais inválidas
- [ ] Navegação para Dashboard após login bem-sucedido

**Dashboard:**
- [ ] Menu lateral visível
- [ ] Cards de estatísticas carregados
- [ ] Navegação entre módulos funcionando
- [ ] Logout funcionando

**Módulo de Pacientes:**
- [ ] Lista de pacientes carregada
- [ ] Paginação funcionando
- [ ] Busca por nome/CPF funcionando
- [ ] Criar novo paciente
- [ ] Editar paciente existente
- [ ] Visualizar detalhes do paciente
- [ ] Deletar paciente (soft delete)

**Módulo de Agendamentos:**
- [ ] Calendar view carregada (dia/semana/mês)
- [ ] Criar novo agendamento
- [ ] Validação de conflito de horário
- [ ] Confirmar agendamento
- [ ] Reagendar
- [ ] Cancelar com motivo

**Módulo de Prontuário:**
- [ ] Criar prontuário
- [ ] Preencher anamnese
- [ ] Preencher odontograma
- [ ] Adicionar evolução
- [ ] Assinar como professor
- [ ] Submeter para aprovação

**Configurações:**
- [ ] Alterar tema (claro/escuro)
- [ ] Alterar idioma (se houver)
- [ ] Atualizar perfil
- [ ] Alterar senha

### 3.7 Testes de Performance

#### Usando DevTools

```bash
# Abrir DevTools
flutter pub global activate devtools
flutter pub global run devtools

# Ou via comando
flutter pub global run devtools --app-id=<app_id>
```

**Métricas para verificar:**
- [ ] Tempo de carregamento inicial < 3s
- [ ] FPS mantido acima de 60fps
- [ ] Memory leaks ausentes
- [ ] Widget rebuilds otimizados

#### Profile Mode

```bash
# Rodar em modo profile para análise de performance
flutter run --profile

# Generate trace
flutter run --profile --trace-startup
```

---

## 4. TESTES DE INTEGRAÇÃO (FRONTEND + BACKEND)

### 4.1 Configurar Ambiente de Teste

#### Backend:
```bash
cd /workspace/backend/DentalClinic.Api
dotnet run --configuration Development
```

#### Frontend:
Configurar `lib/core/config/env_config.dart`:
```dart
static const String apiBaseUrl = 'http://localhost:5000';
```

### 4.2 Script de Teste End-to-End

Criar arquivo `scripts/e2e_test.sh`:

```bash
#!/bin/bash

echo "🚀 Iniciando testes E2E..."

# 1. Testar Health Check da API
echo "📡 Testando Health Check..."
curl -f http://localhost:5000/health || exit 1

# 2. Testar Login
echo "🔐 Testando Login..."
TOKEN=$(curl -s -X POST http://localhost:5000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@clinica.com","password":"Admin123!"}' \
  | jq -r '.accessToken')

if [ -z "$TOKEN" ]; then
  echo "❌ Falha no login"
  exit 1
fi
echo "✅ Login realizado com sucesso"

# 3. Testar Listagem de Pacientes
echo "👥 Testando Listagem de Pacientes..."
curl -f http://localhost:5000/api/patients \
  -H "Authorization: Bearer $TOKEN" || exit 1
echo "✅ Listagem de pacientes OK"

# 4. Testar Criação de Paciente
echo "➕ Testando Criação de Paciente..."
PATIENT_ID=$(curl -s -X POST http://localhost:5000/api/patients \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{
    "name":"Paciente Teste",
    "cpf":"000.000.000-00",
    "email":"teste@email.com",
    "phone":"(11) 99999-9999",
    "birthDate":"1990-01-01"
  }' \
  | jq -r '.id')

echo "✅ Paciente criado com ID: $PATIENT_ID"

# 5. Testar Criação de Agendamento
echo "📅 Testando Criação de Agendamento..."
curl -s -X POST http://localhost:5000/api/appointments \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d "{
    \"patientId\":$PATIENT_ID,
    \"professionalId\":1,
    \"startTime\":\"2026-07-20T14:00:00\",
    \"endTime\":\"2026-07-20T15:00:00\",
    \"procedureId\":1,
    \"clinicId\":1
  }" || exit 1
echo "✅ Agendamento criado com sucesso"

# 6. Limpeza
echo "🧹 Limpando dados de teste..."
curl -s -X DELETE "http://localhost:5000/api/patients/$PATIENT_ID" \
  -H "Authorization: Bearer $TOKEN"

echo "✅ Todos os testes E2E passaram!"
```

#### Executar Script E2E

```bash
chmod +x scripts/e2e_test.sh
./scripts/e2e_test.sh
```

### 4.3 Testes com Postman/Newman

#### Exportar Collection do Postman

1. Criar collection no Postman com todos os endpoints
2. Adicionar environment variables:
   - `baseUrl`: `http://localhost:5000`
   - `accessToken`: (será setado automaticamente)
3. Exportar collection e environment

#### Executar com Newman

```bash
# Instalar Newman
npm install -g newman

# Executar collection
newman run OdontoClinica.postman_collection.json \
  -e OdontoClinica.postman_environment.json \
  --reporters cli,json \
  --reporter-json-export results.json
```

---

## 5. CHECKLIST DE VALIDAÇÃO

### 5.1 Backend

#### Funcional
- [ ] ✅ CRUD de Usuários completo
- [ ] ✅ Autenticação JWT funcionando
- [ ] ✅ Refresh Token implementado
- [ ] ✅ Logout revogando token
- [ ] ✅ CRUD de Pacientes completo
- [ ] ✅ Validação de CPF única
- [ ] ✅ CRUD de Procedimentos
- [ ] ✅ Agendamento com validação de conflito
- [ ] ✅ Status flow de agendamentos
- [ ] ✅ Prontuário com status flow
- [ ] ✅ Odontograma interativo (backend ready)
- [ ] ✅ Upload de anexos
- [ ] ✅ Geração de receitas/atestados
- [ ] ✅ Relatórios gerados
- [ ] ✅ Notificações em tempo real (SignalR)

#### Segurança
- [ ] ✅ JWT com expiração configurável
- [ ] ✅ BCrypt para senhas
- [ ] ✅ RBAC implementado
- [ ] ✅ CORS configurado
- [ ] ✅ Input validation
- [ ] ✅ SQL injection prevention (EF Core)
- [ ] ✅ Auditoria de acessos (LGPD)

#### Performance
- [ ] ✅ Response time < 200ms (P95)
- [ ] ✅ Pagination implementada
- [ ] ✅ Índices no banco de dados
- [ ] ✅ Connection pooling configurado

### 5.2 Frontend

#### Funcional
- [ ] ✅ Tela de Login funcional
- [ ] ✅ Session management
- [ ] ✅ Auto-refresh de tokens
- [ ] ✅ Dashboard com KPIs
- [ ] ✅ Listagem de pacientes com busca
- [ ] ✅ CRUD de pacientes completo
- [ ] ✅ Calendar view funcional
- [ ] ✅ Fluxo de agendamento completo
- [ ] ✅ Prontuário eletrônico
- [ ] ✅ Odontograma interativo
- [ ] ✅ Upload de imagens
- [ ] ✅ Geração de PDFs
- [ ] ✅ Notificações in-app
- [ ] ✅ Theme switching (dark/light)

#### UX/UI
- [ ] ✅ Material 3 design
- [ ] ✅ Responsivo (mobile/tablet/desktop)
- [ ] ✅ Loading states
- [ ] ✅ Error handling amigável
- [ ] ✅ Validações de formulário
- [ ] ✅ Feedback visual de ações

#### Performance
- [ ] ✅ Cold start < 3s
- [ ] ✅ FPS > 60
- [ ] ✅ Lazy loading em listas
- [ ] ✅ Cache de imagens
- [ ] ✅ Offline first (Drift)

### 5.3 Integração

- [ ] ✅ Frontend consumindo APIs corretamente
- [ ] ✅ Tratamento de erros de rede
- [ ] ✅ Timeout configurado
- [ ] ✅ Retry logic implementada
- [ ] ✅ SignalR conectado e recebendo updates
- [ ] ✅ Sync offline-online funcionando

---

## 6. FERRAMENTAS RECOMENDADAS

### Backend
- **Postman/Insomnia**: Testes manuais de API
- **Swagger UI**: Documentação e testes rápidos
- **k6/Locust**: Testes de carga
- **dotnet-coverage**: Cobertura de testes
- **BenchmarkDotNet**: Benchmarks de performance

### Frontend
- **Flutter DevTools**: Profiling e debugging
- **integration_test**: Testes E2E
- **mockito**: Mocks para testes unitários
- **golden_toolkit**: Testes de snapshot (golden tests)

### Banco de Dados
- **pgAdmin/DBeaver**: Gestão do PostgreSQL
- **pg_stat_statements**: Monitoramento de queries

### CI/CD
- **GitHub Actions/GitLab CI**: Automação de testes
- **SonarQube**: Análise estática de código

---

## 7. TROUBLESHOOTING

### Backend

**Erro: Unable to connect to database**
```bash
# Verificar se PostgreSQL está rodando
sudo service postgresql status

# Reiniciar serviço
sudo service postgresql restart

# Testar conexão
psql -U postgres -d odonto_clinica -c "SELECT 1"
```

**Erro: Migration failed**
```bash
# Remover migrações e recriar
dotnet ef migrations remove
dotnet ef migrations add InitialCreate
dotnet ef database update
```

**Erro: JWT validation failed**
```bash
# Verificar se a chave JWT tem 32+ caracteres
# Verificar Issuer e Audience no appsettings.json
```

### Frontend

**Erro: Build failed after code generation**
```bash
# Limpar build
flutter clean

# Reinstalar dependências
flutter pub get

# Regenerar código
flutter pub run build_runner build --delete-conflicting-outputs
```

**Erro: Connection refused to API**
```bash
# Verificar se API está rodando
curl http://localhost:5000/health

# Verificar CORS no backend
# Verificar se baseUrl está correto no env_config.dart
```

**Erro: Testes falhando**
```bash
# Limpar cache de testes
flutter clean

# Rodar testes com verbose
flutter test --verbose
```

---

## 8. RELATÓRIO DE TESTES

### Template de Relatório

```markdown
# Relatório de Testes - OdontoClinica

## Data: YYYY-MM-DD
## Versão: 1.0.0

### Resumo Executivo
- **Total de Testes**: X
- **Passaram**: Y
- **Falharam**: Z
- **Cobertura**: W%

### Backend
#### Testes Unitários
- Passaram: X/Y
- Cobertura: Z%

#### Testes de Integração
- Passaram: X/Y

#### Performance
- Avg Response Time: X ms
- P95 Response Time: Y ms
- P99 Response Time: Z ms

### Frontend
#### Testes Unitários
- Passaram: X/Y
- Cobertura: Z%

#### Testes de Widget
- Passaram: X/Y

#### Testes de Integração
- Passaram: X/Y

#### Performance
- Cold Start: X s
- FPS Médio: Y

### Issues Encontradas
1. [CRÍTICO] Descrição do issue
   - Steps to reproduce
   - Expected behavior
   - Actual behavior
   
2. [ALTO] Descrição do issue
...

### Recomendações
1. ...
2. ...

### Status: ✅ APROVADO / ❌ REPROVADO
```

---

## 9. CONCLUSÃO

Este guia cobre todo o processo de testagem do sistema OdontoClinica, desde testes unitários até testes E2E. Siga os passos na ordem apresentada para garantir uma validação completa do sistema.

**Próximos Passos:**
1. Executar testes unitários do backend
2. Executar testes de integração da API
3. Executar testes unitários do frontend
4. Executar testes de widget
5. Executar testes manuais no emulador
6. Executar testes E2E
7. Gerar relatório de cobertura
8. Corrigir issues encontrados
9. Re-executar testes

**Meta de Cobertura:**
- Backend: >80%
- Frontend: >80%

---

**Documentação Complementar:**
- [QUICK_START.md](./QUICK_START.md) - Setup inicial
- [ARCHITECTURE.md](./ARCHITECTURE.md) - Arquitetura do sistema
- [VALIDATION_CHECKLIST.md](./VALIDATION_CHECKLIST.md) - Checklist de validação

---

*Última atualização: Julho/2026*
