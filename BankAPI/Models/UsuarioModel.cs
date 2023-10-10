namespace BankAPI.Models
{
    public class UsuarioModel
    {
        public int? ID { get; set; }
        public string? ChavePIX { get; set; }
        public string? Nome { get; set; }
        public string? Sobrenome { get; set; }
        public float? Dinheiro { get; set; }
        public int? CartaoID { get; set; }
    }
}