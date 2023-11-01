namespace BankAPI.Models
{
    public class UsuarioModel
    {
        public int? ID { get; set; }
        public string? ChavePIX { get; set; }
        public string? Nome { get; set; }
        public string? Sobrenome { get; set; }
        public float? Dinheiro { get; set; }
        public CartaoModel? Cartao { get; set; }

        public string GerarChavePix(int tamanho)
        {
            var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            var random = new Random();
            var result = new string(
                Enumerable.Repeat(chars, tamanho)
                        .Select(s => s[random.Next(s.Length)])
                        .ToArray());
             return result;
        }
    }
}