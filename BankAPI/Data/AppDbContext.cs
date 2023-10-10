using BankAPI.Models;
using Microsoft.EntityFrameworkCore;

namespace BankAPI.Data
{
    public class AppDbContext : DbContext
    {
        public DbSet<CartaoModel>? Cartoes { get; set; }
        public DbSet<ContaModel>? Contas { get; set; }
        public DbSet<FaturaModel>? Faturas { get; set; }
        public DbSet<TransacaoModel>? Transacoes { get; set; }
        public DbSet<UsuarioModel>? Usuarios { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder.UseSqlite("DataSource=tds.db;Cache=Shared");
    }
}