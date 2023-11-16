import 'package:flutter/foundation.dart';
import 'package:mybank_app/models/logged_user_dto.dart';
import 'package:mybank_app/models/pix_historico.dart';
import 'package:mybank_app/models/pix_response.dart';
import 'package:mybank_app/models/response_dto.dart';

abstract class IRestService extends ChangeNotifier {
  //login and register
  Future<ResponseDTO> loginAsync(String user, String password);
  Future<ResponseDTO> registerAsync(String user, String password);
  Future<ResponseDTO> createUserAsync(
      String pix, String nome, String sobrenome);
  Future<ResponseDTO> editAccountAsync(
      String nomeUsuario, String senha, String novaSenha);
  Future<ResponseDTO> editUserAsync(
      String nome, String sobrenome, String senha);
  Future<ResponseDTO> verificarChavePixAsync(String chavePix);
  Future<ResponseDTO> fazerPixAsync(
      String chavePix, String valor, String senha);
  Future<ResponseDTO> editarChavePixAsync(String chavePix, String senha);
  Future<ResponseDTO> getListPixAsync();
  List<PixHistoricoDto>? getPixHistorico();
  LoggedUserDto? getLoggedInfo();
  PixResponseDto? getPixresponse();
}
