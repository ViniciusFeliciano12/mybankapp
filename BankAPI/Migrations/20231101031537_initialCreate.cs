using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace BankAPI.Migrations
{
    /// <inheritdoc />
    public partial class initialCreate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Cartoes",
                columns: table => new
                {
                    ID = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    Numero = table.Column<string>(type: "TEXT", nullable: true),
                    Senha = table.Column<string>(type: "TEXT", nullable: true),
                    CreditoDisponivel = table.Column<float>(type: "REAL", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Cartoes", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "Contas",
                columns: table => new
                {
                    ID = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    NomeUsuario = table.Column<string>(type: "TEXT", nullable: true),
                    Senha = table.Column<string>(type: "TEXT", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Contas", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "Faturas",
                columns: table => new
                {
                    ID = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    Pago = table.Column<bool>(type: "INTEGER", nullable: true),
                    Mes = table.Column<DateTime>(type: "TEXT", nullable: true),
                    CartaoModelID = table.Column<int>(type: "INTEGER", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Faturas", x => x.ID);
                    table.ForeignKey(
                        name: "FK_Faturas_Cartoes_CartaoModelID",
                        column: x => x.CartaoModelID,
                        principalTable: "Cartoes",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "Usuarios",
                columns: table => new
                {
                    ID = table.Column<int>(type: "INTEGER", nullable: false),
                    ChavePIX = table.Column<string>(type: "TEXT", nullable: true),
                    Nome = table.Column<string>(type: "TEXT", nullable: true),
                    Sobrenome = table.Column<string>(type: "TEXT", nullable: true),
                    Dinheiro = table.Column<float>(type: "REAL", nullable: true),
                    CartaoID = table.Column<int>(type: "INTEGER", nullable: true),
                    ContaID = table.Column<int>(type: "INTEGER", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Usuarios", x => x.ID);
                    table.ForeignKey(
                        name: "FK_Usuarios_Cartoes_CartaoID",
                        column: x => x.CartaoID,
                        principalTable: "Cartoes",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK_Usuarios_Contas_ContaID",
                        column: x => x.ContaID,
                        principalTable: "Contas",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK_Usuarios_Contas_ID",
                        column: x => x.ID,
                        principalTable: "Contas",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Transacoes",
                columns: table => new
                {
                    ID = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    Valor = table.Column<float>(type: "REAL", nullable: true),
                    DescricaoCompra = table.Column<string>(type: "TEXT", nullable: true),
                    Pago = table.Column<bool>(type: "INTEGER", nullable: true),
                    FaturaModelID = table.Column<int>(type: "INTEGER", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Transacoes", x => x.ID);
                    table.ForeignKey(
                        name: "FK_Transacoes_Faturas_FaturaModelID",
                        column: x => x.FaturaModelID,
                        principalTable: "Faturas",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateIndex(
                name: "IX_Faturas_CartaoModelID",
                table: "Faturas",
                column: "CartaoModelID");

            migrationBuilder.CreateIndex(
                name: "IX_Transacoes_FaturaModelID",
                table: "Transacoes",
                column: "FaturaModelID");

            migrationBuilder.CreateIndex(
                name: "IX_Usuarios_CartaoID",
                table: "Usuarios",
                column: "CartaoID");

            migrationBuilder.CreateIndex(
                name: "IX_Usuarios_ContaID",
                table: "Usuarios",
                column: "ContaID");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Transacoes");

            migrationBuilder.DropTable(
                name: "Usuarios");

            migrationBuilder.DropTable(
                name: "Faturas");

            migrationBuilder.DropTable(
                name: "Contas");

            migrationBuilder.DropTable(
                name: "Cartoes");
        }
    }
}
