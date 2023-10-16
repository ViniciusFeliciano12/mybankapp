import 'package:flutter/material.dart';
import 'package:mybank_app/services/rest_service.dart';
import 'package:mybank_app/view/home_page.dart';
import 'package:mybank_app/view/register_page.dart';

import '../services/interfaces/irest_service.dart';
import '../services/service_locator.dart';
import '../utils/navigation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  final IRestService _restService = getIt<IRestService>();

  void _performLogin(BuildContext context) async {
    final isValidUser = await _restService.loginAsync(
      userController.text,
      passwordController.text,
    );

    if (isValidUser) {
      navigateWithSlideTransition(
        context,
        const MyHomePage(title: "logado"),
      );
      print("logado");
    } else {
      print("usuario invalido");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
              TextField(controller: passwordController),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    _performLogin(context);
                  },
                  child: const Text('Login')),
              ElevatedButton(
                  onPressed: () {
                    navigateWithSlideTransition(context, const RegisterPage());
                  },
                  child: const Text('Register')),
            ],
          ),
        ),
      ),
    );
  }
}
