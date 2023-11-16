class PixHistoricoDto {
  String nomePagante;
  String nomeRecebinte;
  bool pagante;
  int valor;

  PixHistoricoDto(
      {required this.nomePagante,
      required this.nomeRecebinte,
      required this.pagante,
      required this.valor});

  factory PixHistoricoDto.fromJson(Map<String, dynamic> json) {
    return PixHistoricoDto(
        nomePagante: json['nomePagante'] as String,
        nomeRecebinte: json['nomeRecebinte'] as String,
        pagante: json['pagante'] as bool,
        valor: json['valor'] as int);
  }
}
