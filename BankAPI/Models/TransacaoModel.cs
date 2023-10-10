namespace BankAPI.Models
{
    public class TransacaoModel
    {
        public int? ID { get; set; }
        public float? Valor { get; set; }
        public string? DescricaoCompra { get; set; }
        public bool? Pago { get; set; }
    }
}