namespace BankAPI.Models
{
    public class ContaModel
    {
        public int? ID { get; set; }
        public string? NomeUsuario { get; set; }
        public string? Senha { get; set; }
        public UsuarioModel? Usuario { get; set; }
    }
}