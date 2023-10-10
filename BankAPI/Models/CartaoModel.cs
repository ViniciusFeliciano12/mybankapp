namespace BankAPI.Models
{
    public class CartaoModel
    {
        public int? ID { get; set; }
        public string? Numero { get; set; }
        public string? Senha { get; set; }
        public float? CreditoDisponivel { get; set; }
        public List<FaturaModel>? Faturas { get; set; }
    }
}