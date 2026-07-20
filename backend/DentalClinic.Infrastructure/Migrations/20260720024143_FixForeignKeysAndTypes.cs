using System;
using System.Collections.Generic;
using DentalClinic.Core.Domain.Entities;
using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace DentalClinic.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class FixForeignKeysAndTypes : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "clinicas",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Name = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    Description = table.Column<string>(type: "character varying(1000)", maxLength: 1000, nullable: false),
                    Specialty = table.Column<int>(type: "integer", nullable: false),
                    endereco_rua = table.Column<string>(type: "character varying(255)", maxLength: 255, nullable: false),
                    endereco_numero = table.Column<string>(type: "character varying(20)", maxLength: 20, nullable: false),
                    Address_Complement = table.Column<string>(type: "text", nullable: true),
                    endereco_bairro = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    endereco_cidade = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    endereco_estado = table.Column<string>(type: "character varying(2)", maxLength: 2, nullable: false),
                    endereco_cep = table.Column<string>(type: "character varying(10)", maxLength: 10, nullable: false),
                    MaxCapacity = table.Column<int>(type: "integer", nullable: false),
                    CoordinatorUserId = table.Column<Guid>(type: "uuid", nullable: false),
                    IsActive = table.Column<bool>(type: "boolean", nullable: false, defaultValue: true),
                    OpeningTime = table.Column<string>(type: "character varying(5)", maxLength: 5, nullable: false),
                    ClosingTime = table.Column<string>(type: "character varying(5)", maxLength: 5, nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_clinicas", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "LogsAuditoria",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Usuario = table.Column<string>(type: "text", nullable: false),
                    Acao = table.Column<string>(type: "text", nullable: false),
                    Tabela = table.Column<string>(type: "text", nullable: false),
                    DadosAntigos = table.Column<string>(type: "text", nullable: false),
                    DadosNovos = table.Column<string>(type: "text", nullable: false),
                    DataHora = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    IpOrigem = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LogsAuditoria", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "pacientes",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "character varying(150)", maxLength: 150, nullable: false),
                    cpf = table.Column<string>(type: "character varying(14)", maxLength: 14, nullable: false),
                    RG = table.Column<string>(type: "character varying(20)", maxLength: 20, nullable: true),
                    email = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    Phone = table.Column<string>(type: "character varying(20)", maxLength: 20, nullable: false),
                    AlternatePhone = table.Column<string>(type: "character varying(20)", maxLength: 20, nullable: true),
                    Gender = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: true),
                    DateOfBirth = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    Address = table.Column<string>(type: "character varying(200)", maxLength: 200, nullable: true),
                    Neighborhood = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: true),
                    City = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: true),
                    State = table.Column<string>(type: "character varying(2)", maxLength: 2, nullable: true),
                    ZipCode = table.Column<string>(type: "character varying(9)", maxLength: 9, nullable: true),
                    ResponsibleName = table.Column<string>(type: "character varying(200)", maxLength: 200, nullable: true),
                    ResponsiblePhone = table.Column<string>(type: "character varying(20)", maxLength: 20, nullable: true),
                    MedicalHistory = table.Column<string>(type: "character varying(500)", maxLength: 500, nullable: true),
                    Allergies = table.Column<string>(type: "character varying(500)", maxLength: 500, nullable: true),
                    Medications = table.Column<string>(type: "character varying(500)", maxLength: 500, nullable: true),
                    IsActive = table.Column<bool>(type: "boolean", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_pacientes", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "UserSessions",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    UserId = table.Column<Guid>(type: "uuid", nullable: false),
                    Token = table.Column<string>(type: "text", nullable: false),
                    ExpiryDate = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    IsRevoked = table.Column<bool>(type: "boolean", nullable: false),
                    CreatedByIp = table.Column<string>(type: "text", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UserSessions", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "usuarios",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Name = table.Column<string>(type: "character varying(255)", maxLength: 255, nullable: false),
                    email = table.Column<string>(type: "character varying(255)", maxLength: 255, nullable: false),
                    PasswordHash = table.Column<string>(type: "text", nullable: false),
                    cpf = table.Column<string>(type: "character varying(11)", maxLength: 11, nullable: false),
                    DateOfBirth = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    Phone = table.Column<string>(type: "character varying(20)", maxLength: 20, nullable: false),
                    endereco_rua = table.Column<string>(type: "character varying(255)", maxLength: 255, nullable: false),
                    endereco_numero = table.Column<string>(type: "character varying(20)", maxLength: 20, nullable: false),
                    Address_Complement = table.Column<string>(type: "text", nullable: true),
                    endereco_bairro = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    endereco_cidade = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    endereco_estado = table.Column<string>(type: "character varying(2)", maxLength: 2, nullable: false),
                    endereco_cep = table.Column<string>(type: "character varying(10)", maxLength: 10, nullable: false),
                    Roles = table.Column<List<UserRole>>(type: "jsonb", nullable: false),
                    Status = table.Column<int>(type: "integer", nullable: false),
                    EmailConfirmed = table.Column<bool>(type: "boolean", nullable: false),
                    LastLoginAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    FailedLoginAttempts = table.Column<int>(type: "integer", nullable: false),
                    BlockedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_usuarios", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "lista_espera",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    PatientId = table.Column<int>(type: "integer", nullable: false),
                    ClinicId = table.Column<Guid>(type: "uuid", nullable: false),
                    Specialty = table.Column<int>(type: "integer", nullable: false),
                    Priority = table.Column<string>(type: "character varying(20)", maxLength: 20, nullable: false),
                    Observation = table.Column<string>(type: "text", nullable: true),
                    IsResolved = table.Column<bool>(type: "boolean", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_lista_espera", x => x.Id);
                    table.ForeignKey(
                        name: "FK_lista_espera_clinicas_ClinicId",
                        column: x => x.ClinicId,
                        principalTable: "clinicas",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_lista_espera_pacientes_PatientId",
                        column: x => x.PatientId,
                        principalTable: "pacientes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "MedicalRecords",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    PatientId = table.Column<int>(type: "integer", nullable: false),
                    Anamnesis = table.Column<string>(type: "text", nullable: false),
                    ClinicalExam = table.Column<string>(type: "text", nullable: false),
                    Diagnosis = table.Column<string>(type: "text", nullable: false),
                    TreatmentPlan = table.Column<string>(type: "text", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_MedicalRecords", x => x.Id);
                    table.ForeignKey(
                        name: "FK_MedicalRecords_pacientes_PatientId",
                        column: x => x.PatientId,
                        principalTable: "pacientes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "odontogramas",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    PatientId = table.Column<int>(type: "integer", nullable: false),
                    Teeth = table.Column<List<ToothCondition>>(type: "jsonb", nullable: false),
                    UpdatedBy = table.Column<Guid>(type: "uuid", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_odontogramas", x => x.Id);
                    table.ForeignKey(
                        name: "FK_odontogramas_pacientes_PatientId",
                        column: x => x.PatientId,
                        principalTable: "pacientes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "agendamentos",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    PatientId = table.Column<int>(type: "integer", nullable: false),
                    DoctorId = table.Column<Guid>(type: "uuid", nullable: false),
                    StartTime = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    EndTime = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    Status = table.Column<int>(type: "integer", nullable: false),
                    ProcedureName = table.Column<string>(type: "character varying(255)", maxLength: 255, nullable: true),
                    Notes = table.Column<string>(type: "character varying(1000)", maxLength: 1000, nullable: true),
                    ClinicId = table.Column<Guid>(type: "uuid", nullable: false),
                    PatientId1 = table.Column<int>(type: "integer", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_agendamentos", x => x.Id);
                    table.ForeignKey(
                        name: "FK_agendamentos_pacientes_PatientId",
                        column: x => x.PatientId,
                        principalTable: "pacientes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_agendamentos_pacientes_PatientId1",
                        column: x => x.PatientId1,
                        principalTable: "pacientes",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_agendamentos_usuarios_DoctorId",
                        column: x => x.DoctorId,
                        principalTable: "usuarios",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "anamneses",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    PatientId = table.Column<int>(type: "integer", nullable: false),
                    RespostasJson = table.Column<string>(type: "jsonb", nullable: false),
                    CriadoPorId = table.Column<Guid>(type: "uuid", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_anamneses", x => x.Id);
                    table.ForeignKey(
                        name: "FK_anamneses_pacientes_PatientId",
                        column: x => x.PatientId,
                        principalTable: "pacientes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_anamneses_usuarios_CriadoPorId",
                        column: x => x.CriadoPorId,
                        principalTable: "usuarios",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "anexos",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    PacienteId = table.Column<int>(type: "integer", nullable: false),
                    Nome = table.Column<string>(type: "character varying(255)", maxLength: 255, nullable: false),
                    Tipo = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    Url = table.Column<string>(type: "character varying(500)", maxLength: 500, nullable: false),
                    Tamanho = table.Column<long>(type: "bigint", nullable: false),
                    CriadoPorId = table.Column<Guid>(type: "uuid", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_anexos", x => x.Id);
                    table.ForeignKey(
                        name: "FK_anexos_pacientes_PacienteId",
                        column: x => x.PacienteId,
                        principalTable: "pacientes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_anexos_usuarios_CriadoPorId",
                        column: x => x.CriadoPorId,
                        principalTable: "usuarios",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "atestados",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    PatientId = table.Column<int>(type: "integer", nullable: false),
                    DoctorId = table.Column<Guid>(type: "uuid", nullable: false),
                    Content = table.Column<string>(type: "text", nullable: false),
                    DaysOfRest = table.Column<int>(type: "integer", nullable: false),
                    CID = table.Column<string>(type: "character varying(10)", maxLength: 10, nullable: false),
                    ClinicId = table.Column<Guid>(type: "uuid", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_atestados", x => x.Id);
                    table.ForeignKey(
                        name: "FK_atestados_pacientes_PatientId",
                        column: x => x.PatientId,
                        principalTable: "pacientes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_atestados_usuarios_DoctorId",
                        column: x => x.DoctorId,
                        principalTable: "usuarios",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "receitas",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    PatientId = table.Column<int>(type: "integer", nullable: false),
                    DoctorId = table.Column<Guid>(type: "uuid", nullable: false),
                    Observations = table.Column<string>(type: "character varying(1000)", maxLength: 1000, nullable: true),
                    Items = table.Column<List<PrescriptionItem>>(type: "jsonb", nullable: false),
                    ClinicId = table.Column<Guid>(type: "uuid", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_receitas", x => x.Id);
                    table.ForeignKey(
                        name: "FK_receitas_pacientes_PatientId",
                        column: x => x.PatientId,
                        principalTable: "pacientes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_receitas_usuarios_DoctorId",
                        column: x => x.DoctorId,
                        principalTable: "usuarios",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "Attachments",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    PatientId = table.Column<int>(type: "integer", nullable: false),
                    MedicalRecordId = table.Column<int>(type: "integer", nullable: true),
                    FileName = table.Column<string>(type: "character varying(255)", maxLength: 255, nullable: false),
                    FileType = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    Url = table.Column<string>(type: "character varying(500)", maxLength: 500, nullable: false),
                    Description = table.Column<string>(type: "character varying(500)", maxLength: 500, nullable: true),
                    UploadDate = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    UploadedByUserId = table.Column<int>(type: "integer", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Attachments", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Attachments_MedicalRecords_MedicalRecordId",
                        column: x => x.MedicalRecordId,
                        principalTable: "MedicalRecords",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Attachments_pacientes_PatientId",
                        column: x => x.PatientId,
                        principalTable: "pacientes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "evolucoes_clinicas",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    PatientId = table.Column<int>(type: "integer", nullable: false),
                    StudentId = table.Column<Guid>(type: "uuid", nullable: false),
                    ProfessorId = table.Column<Guid>(type: "uuid", nullable: false),
                    ClinicId = table.Column<Guid>(type: "uuid", nullable: false),
                    Description = table.Column<string>(type: "text", nullable: false),
                    IsSignedByProfessor = table.Column<bool>(type: "boolean", nullable: false, defaultValue: false),
                    SignedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    MedicalRecordId = table.Column<int>(type: "integer", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_evolucoes_clinicas", x => x.Id);
                    table.ForeignKey(
                        name: "FK_evolucoes_clinicas_MedicalRecords_MedicalRecordId",
                        column: x => x.MedicalRecordId,
                        principalTable: "MedicalRecords",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_evolucoes_clinicas_clinicas_ClinicId",
                        column: x => x.ClinicId,
                        principalTable: "clinicas",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_evolucoes_clinicas_pacientes_PatientId",
                        column: x => x.PatientId,
                        principalTable: "pacientes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_evolucoes_clinicas_usuarios_ProfessorId",
                        column: x => x.ProfessorId,
                        principalTable: "usuarios",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_evolucoes_clinicas_usuarios_StudentId",
                        column: x => x.StudentId,
                        principalTable: "usuarios",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "TreatmentItems",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    TreatmentPlanId = table.Column<Guid>(type: "uuid", nullable: false),
                    ProcedureId = table.Column<Guid>(type: "uuid", nullable: false),
                    ProcedureName = table.Column<string>(type: "text", nullable: false),
                    Value = table.Column<decimal>(type: "numeric", nullable: false),
                    ToothNumber = table.Column<int>(type: "integer", nullable: true),
                    Status = table.Column<int>(type: "integer", nullable: false),
                    MedicalRecordId = table.Column<int>(type: "integer", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TreatmentItems", x => x.Id);
                    table.ForeignKey(
                        name: "FK_TreatmentItems_MedicalRecords_MedicalRecordId",
                        column: x => x.MedicalRecordId,
                        principalTable: "MedicalRecords",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateIndex(
                name: "IX_agendamentos_ClinicId",
                table: "agendamentos",
                column: "ClinicId");

            migrationBuilder.CreateIndex(
                name: "IX_agendamentos_DoctorId",
                table: "agendamentos",
                column: "DoctorId");

            migrationBuilder.CreateIndex(
                name: "IX_agendamentos_PatientId",
                table: "agendamentos",
                column: "PatientId");

            migrationBuilder.CreateIndex(
                name: "IX_agendamentos_PatientId1",
                table: "agendamentos",
                column: "PatientId1");

            migrationBuilder.CreateIndex(
                name: "IX_agendamentos_StartTime_EndTime",
                table: "agendamentos",
                columns: new[] { "StartTime", "EndTime" });

            migrationBuilder.CreateIndex(
                name: "IX_anamneses_CriadoPorId",
                table: "anamneses",
                column: "CriadoPorId");

            migrationBuilder.CreateIndex(
                name: "IX_anamneses_PatientId",
                table: "anamneses",
                column: "PatientId",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_anexos_CriadoPorId",
                table: "anexos",
                column: "CriadoPorId");

            migrationBuilder.CreateIndex(
                name: "IX_anexos_PacienteId",
                table: "anexos",
                column: "PacienteId");

            migrationBuilder.CreateIndex(
                name: "IX_atestados_DoctorId",
                table: "atestados",
                column: "DoctorId");

            migrationBuilder.CreateIndex(
                name: "IX_atestados_PatientId",
                table: "atestados",
                column: "PatientId");

            migrationBuilder.CreateIndex(
                name: "IX_Attachments_MedicalRecordId",
                table: "Attachments",
                column: "MedicalRecordId");

            migrationBuilder.CreateIndex(
                name: "IX_Attachments_PatientId",
                table: "Attachments",
                column: "PatientId");

            migrationBuilder.CreateIndex(
                name: "IX_evolucoes_clinicas_ClinicId",
                table: "evolucoes_clinicas",
                column: "ClinicId");

            migrationBuilder.CreateIndex(
                name: "IX_evolucoes_clinicas_CreatedAt",
                table: "evolucoes_clinicas",
                column: "CreatedAt");

            migrationBuilder.CreateIndex(
                name: "IX_evolucoes_clinicas_MedicalRecordId",
                table: "evolucoes_clinicas",
                column: "MedicalRecordId");

            migrationBuilder.CreateIndex(
                name: "IX_evolucoes_clinicas_PatientId",
                table: "evolucoes_clinicas",
                column: "PatientId");

            migrationBuilder.CreateIndex(
                name: "IX_evolucoes_clinicas_ProfessorId",
                table: "evolucoes_clinicas",
                column: "ProfessorId");

            migrationBuilder.CreateIndex(
                name: "IX_evolucoes_clinicas_StudentId",
                table: "evolucoes_clinicas",
                column: "StudentId");

            migrationBuilder.CreateIndex(
                name: "IX_lista_espera_ClinicId",
                table: "lista_espera",
                column: "ClinicId");

            migrationBuilder.CreateIndex(
                name: "IX_lista_espera_IsResolved",
                table: "lista_espera",
                column: "IsResolved");

            migrationBuilder.CreateIndex(
                name: "IX_lista_espera_PatientId",
                table: "lista_espera",
                column: "PatientId");

            migrationBuilder.CreateIndex(
                name: "IX_MedicalRecords_PatientId",
                table: "MedicalRecords",
                column: "PatientId");

            migrationBuilder.CreateIndex(
                name: "IX_odontogramas_PatientId",
                table: "odontogramas",
                column: "PatientId",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_odontogramas_UpdatedAt",
                table: "odontogramas",
                column: "UpdatedAt");

            migrationBuilder.CreateIndex(
                name: "IX_pacientes_cpf",
                table: "pacientes",
                column: "cpf",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_pacientes_Name",
                table: "pacientes",
                column: "Name");

            migrationBuilder.CreateIndex(
                name: "IX_receitas_CreatedAt",
                table: "receitas",
                column: "CreatedAt");

            migrationBuilder.CreateIndex(
                name: "IX_receitas_DoctorId",
                table: "receitas",
                column: "DoctorId");

            migrationBuilder.CreateIndex(
                name: "IX_receitas_PatientId",
                table: "receitas",
                column: "PatientId");

            migrationBuilder.CreateIndex(
                name: "IX_TreatmentItems_MedicalRecordId",
                table: "TreatmentItems",
                column: "MedicalRecordId");

            migrationBuilder.CreateIndex(
                name: "IX_usuarios_cpf",
                table: "usuarios",
                column: "cpf",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_usuarios_email",
                table: "usuarios",
                column: "email",
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "agendamentos");

            migrationBuilder.DropTable(
                name: "anamneses");

            migrationBuilder.DropTable(
                name: "anexos");

            migrationBuilder.DropTable(
                name: "atestados");

            migrationBuilder.DropTable(
                name: "Attachments");

            migrationBuilder.DropTable(
                name: "evolucoes_clinicas");

            migrationBuilder.DropTable(
                name: "lista_espera");

            migrationBuilder.DropTable(
                name: "LogsAuditoria");

            migrationBuilder.DropTable(
                name: "odontogramas");

            migrationBuilder.DropTable(
                name: "receitas");

            migrationBuilder.DropTable(
                name: "TreatmentItems");

            migrationBuilder.DropTable(
                name: "UserSessions");

            migrationBuilder.DropTable(
                name: "clinicas");

            migrationBuilder.DropTable(
                name: "usuarios");

            migrationBuilder.DropTable(
                name: "MedicalRecords");

            migrationBuilder.DropTable(
                name: "pacientes");
        }
    }
}
