namespace BankAPI.Models
{
    public class FaturaModel
    {
        public int? ID { get; set; }
        public bool? Pago { get; set; }
        public DateTime? Mes { get; set; }
        public List<TransacaoModel>? Transacoes { get; set; }
    }
}