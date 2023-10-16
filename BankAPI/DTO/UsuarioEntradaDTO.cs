using BankAPI.Models;

namespace BankAPI.DTO
{
    public class UsuarioEntradaDTO
    {
        public string? ChavePIX { get; set; }
        public string? Nome { get; set; }
        public string? Sobrenome { get; set; }
        public float? Dinheiro { get; set; }
        public CartaoModel? Cartao { get; set; }
    }
}