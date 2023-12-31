import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mybank_app/models/logged_user_dto.dart';
import 'package:mybank_app/models/pix_historico.dart';
import 'package:mybank_app/models/pix_response.dart';
import 'package:mybank_app/models/response_dto.dart';
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
  PixResponseDto? pixResponse;
  List<PixHistoricoDto>? pixHistorico;

  static String get apiEndpoint => _getKey('API_ENDPOINT');

  @override
  Future<ResponseDTO> loginAsync(String user, String password) async {
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
        return ResponseDTO(success: true);
      } else {
        debugPrint('Erro: ${response.reasonPhrase}');
        return ResponseDTO(success: false, message: response.body);
      }
    } catch (exception) {
      debugPrint('Exceção: $exception');
      return ResponseDTO(success: false, message: exception.toString());
    }
  }

  @override
  Future<ResponseDTO> registerAsync(String user, String password) async {
    Map<String, String> data = {
      'nomeUsuario': user,
      'senha': password,
    };

    try {
      var response = await http.post(
        Uri.parse("$apiEndpoint/registerAsync"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        return ResponseDTO(success: true);
      } else {
        debugPrint('Erro: ${response.body}');
        return ResponseDTO(success: false, message: response.body);
      }
    } catch (exception) {
      debugPrint('Exceção: $exception');
      return ResponseDTO(success: false, message: exception.toString());
    }
  }

  @override
  Future<ResponseDTO> createUserAsync(
      String pix, String nome, String sobrenome) async {
    Map<String, String> data = {
      'id': usuario!.id.toString(),
      'nomeUsuario': usuario!.username,
      'senha': usuario!.password,
      'chavePIX': pix,
      'nome': nome,
      'sobrenome': sobrenome
    };

    try {
      var response = await http.post(
        Uri.parse("$apiEndpoint/gerarUsuarioAsync"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        final dynamic jsonResponse = jsonDecode(response.body);
        usuario = LoggedUserDto.fromJson(jsonResponse);
        notifyListeners();
        return ResponseDTO(success: true);
      } else {
        debugPrint('Erro: ${response.body}');
        return ResponseDTO(success: false, message: response.body);
      }
    } catch (exception) {
      debugPrint('Exceção: $exception');
      return ResponseDTO(success: false, message: exception.toString());
    }
  }

  @override
  Future<ResponseDTO> editAccountAsync(
      String nomeUsuario, String senha, String novaSenha) async {
    Map<String, String> data = {
      'id': usuario!.id.toString(),
      'name': nomeUsuario,
      'password': senha,
      'newPassword': novaSenha,
    };

    try {
      var response = await http.put(
        Uri.parse("$apiEndpoint/editAccountAsync"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final dynamic jsonResponse = jsonDecode(response.body);
        usuario = LoggedUserDto.fromJson(jsonResponse);
        notifyListeners();
        return ResponseDTO(success: true);
      } else {
        debugPrint('Erro: ${response.body}');
        return ResponseDTO(success: false, message: response.body);
      }
    } catch (exception) {
      debugPrint('Exceção: $exception');
      return ResponseDTO(success: false, message: exception.toString());
    }
  }

  @override
  Future<ResponseDTO> editUserAsync(
      String nome, String sobrenome, String senha) async {
    Map<String, String> data = {
      'idUser': usuario!.usuario!.id.toString(),
      'idAccount': usuario!.id.toString(),
      'name': nome,
      'sobrenome': sobrenome,
      'password': senha,
    };

    try {
      var response = await http.put(
        Uri.parse("$apiEndpoint/editUserAsync"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final dynamic jsonResponse = jsonDecode(response.body);
        usuario = LoggedUserDto.fromJson(jsonResponse);
        notifyListeners();
        return ResponseDTO(success: true);
      } else {
        debugPrint('Erro: ${response.body}');
        return ResponseDTO(success: false, message: response.body);
      }
    } catch (exception) {
      debugPrint('Exceção: $exception');
      return ResponseDTO(success: false, message: exception.toString());
    }
  }

  @override
  Future<ResponseDTO> verificarChavePixAsync(String chavePix) async {
    try {
      var response = await http.post(
        Uri.parse("$apiEndpoint/verificarChavePixAsync"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(chavePix),
      );

      if (response.statusCode == 200) {
        final dynamic jsonResponse = jsonDecode(response.body);
        pixResponse = PixResponseDto.fromJson(jsonResponse);
        return ResponseDTO(success: true);
      } else {
        debugPrint('Erro: ${response.body}');
        return ResponseDTO(success: false, message: response.body);
      }
    } catch (exception) {
      debugPrint('Exceção: $exception');
      return ResponseDTO(success: false, message: exception.toString());
    }
  }

  @override
  Future<ResponseDTO> fazerPixAsync(
      String chavePix, String valor, String senha) async {
    Map<String, String> data = {
      'valor': valor.toString(),
      'idPagante': usuario!.usuario!.id.toString(),
      'chavePixRecebinte': chavePix,
      'password': senha
    };
    try {
      var response = await http.post(
        Uri.parse("$apiEndpoint/fazerPixAsync"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        final dynamic jsonResponse = jsonDecode(response.body);
        usuario = LoggedUserDto.fromJson(jsonResponse);
        notifyListeners();
        return ResponseDTO(success: true);
      } else {
        debugPrint('Erro: ${response.body}');
        return ResponseDTO(success: false, message: response.body);
      }
    } catch (exception) {
      debugPrint('Exceção: $exception');
      return ResponseDTO(success: false, message: exception.toString());
    }
  }

  @override
  Future<ResponseDTO> editarChavePixAsync(String chavePix, String senha) async {
    Map<String, String> data = {
      'idUser': usuario!.usuario!.id.toString(),
      'idAccount': usuario!.id.toString(),
      'chavePIX': chavePix,
      'password': senha
    };
    try {
      var response = await http.post(
        Uri.parse("$apiEndpoint/editarChavePixAsync"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final dynamic jsonResponse = jsonDecode(response.body);
        usuario = LoggedUserDto.fromJson(jsonResponse);
        notifyListeners();
        return ResponseDTO(success: true);
      } else {
        debugPrint('Erro: ${response.body}');
        return ResponseDTO(success: false, message: response.body);
      }
    } catch (exception) {
      debugPrint('Exceção: $exception');
      return ResponseDTO(success: false, message: exception.toString());
    }
  }

  @override
  Future<ResponseDTO> getListPixAsync() async {
    try {
      var response = await http.post(
        Uri.parse("$apiEndpoint/getListPixAsync"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(usuario!.id),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        pixHistorico =
            jsonResponse.map((json) => PixHistoricoDto.fromJson(json)).toList();
        return ResponseDTO(success: true);
      } else {
        debugPrint('Erro: ${response.body}');
        return ResponseDTO(success: false, message: response.body);
      }
    } catch (exception) {
      debugPrint('Exceção: $exception');
      return ResponseDTO(success: false, message: exception.toString());
    }
  }

  @override
  List<PixHistoricoDto>? getPixHistorico() {
    return pixHistorico;
  }

  @override
  PixResponseDto? getPixresponse() {
    return pixResponse;
  }

  @override
  LoggedUserDto? getLoggedInfo() {
    return usuario;
  }
}
