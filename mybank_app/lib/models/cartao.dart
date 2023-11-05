class Cartao {
  int id;
  String numero;
  String senha;
  int creditoDisponivel;

  Cartao(
      {required this.id,
      required this.numero,
      required this.senha,
      required this.creditoDisponivel});

  factory Cartao.fromJson(Map<String, dynamic> json) {
    return Cartao(
      id: json['id'] as int,
      numero: json['numero'] as String,
      senha: json['senha'] as String,
      creditoDisponivel: json['creditoDisponivel'] as int,
    );
  }
}
