import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final userController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register page"),
      ),
      body: Center(
        child: SizedBox(
          height: 260,
          width: 200,
          child: Column(
            children: <Widget>[
              const Text(
                'Usuário: ',
              ),
              const SizedBox(height: 3),
              TextField(
                controller: userController,
              ),
              const SizedBox(height: 19),
              const Text('Senha: '),
              const SizedBox(height: 3),
              TextField(
                controller: passwordController,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () async {
                    String url = "http://192.168.100.14:5041/contas";
                    Map<String, String> data = {
                      'nomeUsuario': userController.text,
                      'senha': passwordController.text,
                    };

                    try {
                      var response = await http.post(
                        Uri.parse(url),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: jsonEncode(
                            data), // Converte o mapa em uma string JSON
                      );

                      if (response.statusCode == 201) {
                        // Manipule a resposta aqui.
                      } else {
                        print('Erro: ${response.reasonPhrase}');
                      }
                    } catch (exception) {
                      print('Exceção: $exception');
                    }
                  },
                  child: const Text('Registrar')),
            ],
          ),
        ),
      ),
    );
  }
}
