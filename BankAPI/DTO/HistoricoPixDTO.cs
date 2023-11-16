namespace BankAPI.Models
{
    public class HistoricoPixDTO
    {
        public string? NomePagante { get ; set; }
        public string? NomeRecebinte { get ; set; }
        public bool? Pagante { get; set; }
        public float? Valor { get; set; }
    }
}