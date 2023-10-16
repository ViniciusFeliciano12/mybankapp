class LoggedUserDto {
  int id;
  String username;
  String password;

  LoggedUserDto(
      {required this.id, required this.username, required this.password});

  factory LoggedUserDto.fromJson(Map<String, dynamic> json) {
    return LoggedUserDto(
      id: json['id'] as int,
      username: json['nomeUsuario'] as String,
      password: json['senha'] as String,
    );
  }
}
