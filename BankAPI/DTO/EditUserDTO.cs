namespace MyBank.DTO
{
    public class EditUserDTO{
        public int? IdUser { get; set; }
        public int? IdAccount { get; set; }
        public string? Name { get; set; }
        public string? Sobrenome { get; set; }
        public string? Password {get; set; }
    }
}