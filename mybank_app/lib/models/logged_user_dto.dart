import 'package:mybank_app/models/usuario.dart';

class LoggedUserDto {
  int id;
  String username;
  String password;
  Usuario? usuario;

  LoggedUserDto(
      {required this.id,
      required this.username,
      required this.password,
      required this.usuario});

  factory LoggedUserDto.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic>? usuarioJson =
        json['usuario'] as Map<String, dynamic>?;
    return LoggedUserDto(
        id: json['id'] as int,
        username: json['nomeUsuario'] as String,
        password: json['senha'] as String,
        usuario: usuarioJson == null ? null : Usuario.fromJson(usuarioJson));
  }
}
