import 'cartao.dart';

class Usuario {
  int id;
  String chavePIX;
  String nome;
  String sobrenome;
  int dinheiro;
  Cartao? cartao;

  Usuario(
      {required this.id,
      required this.chavePIX,
      required this.nome,
      required this.sobrenome,
      required this.dinheiro,
      required this.cartao});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic>? cartaojson = json['cartao'] as Map<String, dynamic>?;

    return Usuario(
        id: json['id'] as int,
        chavePIX: json['chavePIX'] as String,
        nome: json['nome'] as String,
        sobrenome: json['sobrenome'] as String,
        dinheiro: json['dinheiro'] as int,
        cartao: cartaojson == null ? null : Cartao.fromJson(cartaojson));
  }
}
