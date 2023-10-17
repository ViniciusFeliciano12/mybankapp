import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mybank_app/models/logged_user_dto.dart';
import 'package:mybank_app/services/interfaces/irest_service.dart';
import 'package:http/http.dart' as http;

class RestService extends IRestService {
  static String url = "http://192.168.0.4:5041";
  LoggedUserDto? usuario;

  @override
  Future<bool> loginAsync(String user, String password) async {
    try {
      var response = await http.get(Uri.parse("$url/contas/$user/$password"));
      debugPrint(response.toString());
      if (response.statusCode == 200) {
        final dynamic jsonResponse = jsonDecode(response.body);
        usuario = LoggedUserDto.fromJson(jsonResponse);
        return true;
      } else {
        debugPrint('Erro: ${response.reasonPhrase}');
        return false;
      }
    } catch (exception) {
      debugPrint('Exceção: $exception');
      return false;
    }
  }

  @override
  Future<bool> registerAsync(String user, String password) async {
    Map<String, String> data = {
      'nomeUsuario': user,
      'senha': password,
    };

    try {
      var response = await http.post(
        Uri.parse("$url/contas"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        debugPrint('Erro: ${response.reasonPhrase}');
        return false;
      }
    } catch (exception) {
      debugPrint('Exceção: $exception');
      return false;
    }
  }

  @override
  LoggedUserDto? getLoggedInfo() {
    return usuario;
  }
}
