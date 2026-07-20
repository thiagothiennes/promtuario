using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace DentalClinic.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class InitialCreate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_agendamentos_pacientes_PatientId1",
                table: "agendamentos");

            migrationBuilder.DropIndex(
                name: "IX_agendamentos_PatientId1",
                table: "agendamentos");

            migrationBuilder.DropColumn(
                name: "PatientId1",
                table: "agendamentos");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "PatientId1",
                table: "agendamentos",
                type: "integer",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_agendamentos_PatientId1",
                table: "agendamentos",
                column: "PatientId1");

            migrationBuilder.AddForeignKey(
                name: "FK_agendamentos_pacientes_PatientId1",
                table: "agendamentos",
                column: "PatientId1",
                principalTable: "pacientes",
                principalColumn: "Id");
        }
    }
}
