using BankAPI.Models;

namespace BankAPI.DTO
{
    public class GerarUsuarioDTO 
    {
        public int? ID { get; set; }
        public string? NomeUsuario { get; set; }
        public string? Senha { get; set; }
        public string? ChavePIX { get; set; }
        public string? Nome { get; set; }
        public string? Sobrenome { get; set; }
    }
}