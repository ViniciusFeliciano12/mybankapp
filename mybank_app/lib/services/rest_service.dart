import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mybank_app/models/logged_user_dto.dart';
import 'package:mybank_app/services/interfaces/irest_service.dart';
import 'package:http/http.dart' as http;

class RestService extends IRestService {
  static const Map<String, String> _keys = {
    'API_ENDPOINT': String.fromEnvironment('API_ENDPOINT')
  };

  static String _getKey(String key) {
    final value = _keys[key] ?? '';
    if (value.isEmpty) {
      throw Exception('$key is not set in Env');
    }
    return value;
  }

  LoggedUserDto? usuario;

  static String get apiEndpoint => _getKey('API_ENDPOINT');

  @override
  Future<bool> loginAsync(String user, String password) async {
    Map<String, String> data = {
      'name': user,
      'password': password,
    };

    try {
      debugPrint(apiEndpoint);
      var response = await http.post(
        Uri.parse("$apiEndpoint/loginAsync"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

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
        Uri.parse("$apiEndpoint/contas"),
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