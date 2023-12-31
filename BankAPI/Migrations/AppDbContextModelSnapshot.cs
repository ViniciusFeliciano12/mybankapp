﻿// <auto-generated />
using System;
using BankAPI.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

#nullable disable

namespace BankAPI.Migrations
{
    [DbContext(typeof(AppDbContext))]
    partial class AppDbContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder.HasAnnotation("ProductVersion", "7.0.12");

            modelBuilder.Entity("BankAPI.Models.CartaoModel", b =>
                {
                    b.Property<int?>("ID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("INTEGER");

                    b.Property<float?>("CreditoDisponivel")
                        .HasColumnType("REAL");

                    b.Property<string>("Numero")
                        .HasColumnType("TEXT");

                    b.Property<string>("Senha")
                        .HasColumnType("TEXT");

                    b.HasKey("ID");

                    b.ToTable("Cartoes");
                });

            modelBuilder.Entity("BankAPI.Models.ContaModel", b =>
                {
                    b.Property<int?>("ID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("INTEGER");

                    b.Property<string>("NomeUsuario")
                        .HasColumnType("TEXT");

                    b.Property<string>("Senha")
                        .HasColumnType("TEXT");

                    b.HasKey("ID");

                    b.ToTable("Contas");
                });

            modelBuilder.Entity("BankAPI.Models.FaturaModel", b =>
                {
                    b.Property<int?>("ID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("INTEGER");

                    b.Property<int?>("CartaoModelID")
                        .HasColumnType("INTEGER");

                    b.Property<DateTime?>("Mes")
                        .HasColumnType("TEXT");

                    b.Property<bool?>("Pago")
                        .HasColumnType("INTEGER");

                    b.HasKey("ID");

                    b.HasIndex("CartaoModelID");

                    b.ToTable("Faturas");
                });

            modelBuilder.Entity("BankAPI.Models.PixModel", b =>
                {
                    b.Property<int?>("ID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("INTEGER");

                    b.Property<int?>("IDPagante")
                        .HasColumnType("INTEGER");

                    b.Property<int?>("IDRecebinte")
                        .HasColumnType("INTEGER");

                    b.Property<float?>("Valor")
                        .HasColumnType("REAL");

                    b.HasKey("ID");

                    b.ToTable("Pix");
                });

            modelBuilder.Entity("BankAPI.Models.TransacaoModel", b =>
                {
                    b.Property<int?>("ID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("INTEGER");

                    b.Property<string>("DescricaoCompra")
                        .HasColumnType("TEXT");

                    b.Property<int?>("FaturaModelID")
                        .HasColumnType("INTEGER");

                    b.Property<bool?>("Pago")
                        .HasColumnType("INTEGER");

                    b.Property<float?>("Valor")
                        .HasColumnType("REAL");

                    b.HasKey("ID");

                    b.HasIndex("FaturaModelID");

                    b.ToTable("Transacoes");
                });

            modelBuilder.Entity("BankAPI.Models.UsuarioModel", b =>
                {
                    b.Property<int?>("ID")
                        .HasColumnType("INTEGER");

                    b.Property<int?>("CartaoID")
                        .HasColumnType("INTEGER");

                    b.Property<string>("ChavePIX")
                        .HasColumnType("TEXT");

                    b.Property<float?>("Dinheiro")
                        .HasColumnType("REAL");

                    b.Property<string>("Nome")
                        .HasColumnType("TEXT");

                    b.Property<string>("Sobrenome")
                        .HasColumnType("TEXT");

                    b.HasKey("ID");

                    b.HasIndex("CartaoID");

                    b.ToTable("Usuarios");
                });

            modelBuilder.Entity("BankAPI.Models.FaturaModel", b =>
                {
                    b.HasOne("BankAPI.Models.CartaoModel", null)
                        .WithMany("Faturas")
                        .HasForeignKey("CartaoModelID");
                });

            modelBuilder.Entity("BankAPI.Models.TransacaoModel", b =>
                {
                    b.HasOne("BankAPI.Models.FaturaModel", null)
                        .WithMany("Transacoes")
                        .HasForeignKey("FaturaModelID");
                });

            modelBuilder.Entity("BankAPI.Models.UsuarioModel", b =>
                {
                    b.HasOne("BankAPI.Models.CartaoModel", "Cartao")
                        .WithMany()
                        .HasForeignKey("CartaoID");

                    b.HasOne("BankAPI.Models.ContaModel", null)
                        .WithOne("Usuario")
                        .HasForeignKey("BankAPI.Models.UsuarioModel", "ID")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Cartao");
                });

            modelBuilder.Entity("BankAPI.Models.CartaoModel", b =>
                {
                    b.Navigation("Faturas");
                });

            modelBuilder.Entity("BankAPI.Models.ContaModel", b =>
                {
                    b.Navigation("Usuario");
                });

            modelBuilder.Entity("BankAPI.Models.FaturaModel", b =>
                {
                    b.Navigation("Transacoes");
                });
#pragma warning restore 612, 618
        }
    }
}
