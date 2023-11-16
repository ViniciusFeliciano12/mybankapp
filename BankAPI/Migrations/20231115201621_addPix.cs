using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace BankAPI.Migrations
{
    /// <inheritdoc />
    public partial class addPix : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Usuarios_Contas_ContaID",
                table: "Usuarios");

            migrationBuilder.DropIndex(
                name: "IX_Usuarios_ContaID",
                table: "Usuarios");

            migrationBuilder.DropColumn(
                name: "ContaID",
                table: "Usuarios");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "ContaID",
                table: "Usuarios",
                type: "INTEGER",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Usuarios_ContaID",
                table: "Usuarios",
                column: "ContaID");

            migrationBuilder.AddForeignKey(
                name: "FK_Usuarios_Contas_ContaID",
                table: "Usuarios",
                column: "ContaID",
                principalTable: "Contas",
                principalColumn: "ID");
        }
    }
}
