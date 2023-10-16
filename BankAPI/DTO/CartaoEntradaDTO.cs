namespace BankAPI.DTO
{
    public class CartaoEntradaDTO
    {
        public string? Numero { get; set; }
        public string? Senha { get; set; }
        public float? CreditoDisponivel { get; set; }
    }
}