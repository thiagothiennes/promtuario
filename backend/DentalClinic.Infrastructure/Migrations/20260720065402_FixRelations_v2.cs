using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace DentalClinic.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class FixRelations_v2 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "endereco_rua",
                table: "usuarios",
                type: "character varying(255)",
                maxLength: 255,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "character varying(255)",
                oldMaxLength: 255);

            migrationBuilder.AlterColumn<string>(
                name: "endereco_numero",
                table: "usuarios",
                type: "character varying(20)",
                maxLength: 20,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "character varying(20)",
                oldMaxLength: 20);

            migrationBuilder.AlterColumn<string>(
                name: "endereco_estado",
                table: "usuarios",
                type: "character varying(2)",
                maxLength: 2,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "character varying(2)",
                oldMaxLength: 2);

            migrationBuilder.AlterColumn<string>(
                name: "endereco_cidade",
                table: "usuarios",
                type: "character varying(100)",
                maxLength: 100,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "character varying(100)",
                oldMaxLength: 100);

            migrationBuilder.AlterColumn<string>(
                name: "endereco_cep",
                table: "usuarios",
                type: "character varying(10)",
                maxLength: 10,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "character varying(10)",
                oldMaxLength: 10);

            migrationBuilder.AlterColumn<string>(
                name: "endereco_bairro",
                table: "usuarios",
                type: "character varying(100)",
                maxLength: 100,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "character varying(100)",
                oldMaxLength: 100);

            migrationBuilder.AlterColumn<string>(
                name: "cpf",
                table: "usuarios",
                type: "character varying(11)",
                maxLength: 11,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "character varying(11)",
                oldMaxLength: 11);

            migrationBuilder.AlterColumn<string>(
                name: "Phone",
                table: "usuarios",
                type: "character varying(20)",
                maxLength: 20,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "character varying(20)",
                oldMaxLength: 20);

            migrationBuilder.AlterColumn<DateTime>(
                name: "DateOfBirth",
                table: "usuarios",
                type: "timestamp with time zone",
                nullable: true,
                oldClrType: typeof(DateTime),
                oldType: "timestamp with time zone");

            migrationBuilder.AddColumn<int>(
                name: "Role",
                table: "usuarios",
                type: "integer",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<Guid>(
                name: "UserId",
                table: "evolucoes_clinicas",
                type: "uuid",
                nullable: true);

            migrationBuilder.AddColumn<Guid>(
                name: "UserId",
                table: "Attachments",
                type: "uuid",
                nullable: true);

            migrationBuilder.AddColumn<Guid>(
                name: "UserId",
                table: "agendamentos",
                type: "uuid",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_evolucoes_clinicas_UserId",
                table: "evolucoes_clinicas",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_Attachments_UserId",
                table: "Attachments",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_agendamentos_UserId",
                table: "agendamentos",
                column: "UserId");

            migrationBuilder.AddForeignKey(
                name: "FK_agendamentos_usuarios_UserId",
                table: "agendamentos",
                column: "UserId",
                principalTable: "usuarios",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Attachments_usuarios_UserId",
                table: "Attachments",
                column: "UserId",
                principalTable: "usuarios",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_evolucoes_clinicas_usuarios_UserId",
                table: "evolucoes_clinicas",
                column: "UserId",
                principalTable: "usuarios",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_agendamentos_usuarios_UserId",
                table: "agendamentos");

            migrationBuilder.DropForeignKey(
                name: "FK_Attachments_usuarios_UserId",
                table: "Attachments");

            migrationBuilder.DropForeignKey(
                name: "FK_evolucoes_clinicas_usuarios_UserId",
                table: "evolucoes_clinicas");

            migrationBuilder.DropIndex(
                name: "IX_evolucoes_clinicas_UserId",
                table: "evolucoes_clinicas");

            migrationBuilder.DropIndex(
                name: "IX_Attachments_UserId",
                table: "Attachments");

            migrationBuilder.DropIndex(
                name: "IX_agendamentos_UserId",
                table: "agendamentos");

            migrationBuilder.DropColumn(
                name: "Role",
                table: "usuarios");

            migrationBuilder.DropColumn(
                name: "UserId",
                table: "evolucoes_clinicas");

            migrationBuilder.DropColumn(
                name: "UserId",
                table: "Attachments");

            migrationBuilder.DropColumn(
                name: "UserId",
                table: "agendamentos");

            migrationBuilder.AlterColumn<string>(
                name: "endereco_rua",
                table: "usuarios",
                type: "character varying(255)",
                maxLength: 255,
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "character varying(255)",
                oldMaxLength: 255,
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "endereco_numero",
                table: "usuarios",
                type: "character varying(20)",
                maxLength: 20,
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "character varying(20)",
                oldMaxLength: 20,
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "endereco_estado",
                table: "usuarios",
                type: "character varying(2)",
                maxLength: 2,
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "character varying(2)",
                oldMaxLength: 2,
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "endereco_cidade",
                table: "usuarios",
                type: "character varying(100)",
                maxLength: 100,
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "character varying(100)",
                oldMaxLength: 100,
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "endereco_cep",
                table: "usuarios",
                type: "character varying(10)",
                maxLength: 10,
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "character varying(10)",
                oldMaxLength: 10,
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "endereco_bairro",
                table: "usuarios",
                type: "character varying(100)",
                maxLength: 100,
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "character varying(100)",
                oldMaxLength: 100,
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "cpf",
                table: "usuarios",
                type: "character varying(11)",
                maxLength: 11,
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "character varying(11)",
                oldMaxLength: 11,
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "Phone",
                table: "usuarios",
                type: "character varying(20)",
                maxLength: 20,
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "character varying(20)",
                oldMaxLength: 20,
                oldNullable: true);

            migrationBuilder.AlterColumn<DateTime>(
                name: "DateOfBirth",
                table: "usuarios",
                type: "timestamp with time zone",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified),
                oldClrType: typeof(DateTime),
                oldType: "timestamp with time zone",
                oldNullable: true);
        }
    }
}
