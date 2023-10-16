import 'dart:convert';

import 'package:mybank_app/models/logged_user_dto.dart';
import 'package:mybank_app/services/interfaces/irest_service.dart';
import 'package:http/http.dart' as http;

class RestService extends IRestService {
  static String url = "http://192.168.100.14:5041";
  LoggedUserDto? usuario = null;

  @override
  Future<bool> loginAsync(String user, String password) async {
    try {
      var response = await http.get(Uri.parse("$url/contas/$user/$password"));
      print(response);
      if (response.statusCode == 200) {
        final dynamic jsonResponse = jsonDecode(response.body);
        usuario = LoggedUserDto.fromJson(jsonResponse);
        return true;
      } else {
        print('Erro: ${response.reasonPhrase}');
        return false;
      }
    } catch (exception) {
      print('Exceção: $exception');
      return false;
    }
  }

  @override
  LoggedUserDto? getUserLogged() {
    return usuario;
  }
}
