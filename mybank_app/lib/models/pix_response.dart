class PixResponseDto {
  String chavePIX;
  String name;
  String lastName;

  PixResponseDto({
    required this.chavePIX,
    required this.name,
    required this.lastName,
  });

  factory PixResponseDto.fromJson(Map<String, dynamic> json) {
    return PixResponseDto(
        chavePIX: json['chavePIX'] as String,
        name: json['nome'] as String,
        lastName: json['sobrenome'] as String);
  }
}
