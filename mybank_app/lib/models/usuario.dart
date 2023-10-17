class Usuario {
  int id;
  String chavePIX;
  String nome;
  String sobrenome;
  int dinheiro;

  Usuario(
      {required this.id,
      required this.chavePIX,
      required this.nome,
      required this.sobrenome,
      required this.dinheiro});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'] as int,
      chavePIX: json['nomeUsuario'] as String,
      nome: json['senha'] as String,
      sobrenome: json['sobrenome'] as String,
      dinheiro: json['dinheiro'] as int,
    );
  }
}
