import 'package:flutter/material.dart';
import 'package:mybank_app/services/service_locator.dart';
import 'package:mybank_app/utils/single_response_message.dart';
import '../services/interfaces/irest_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  final IRestService _restService = getIt<IRestService>();

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
                    var registerSuccess = await _restService.registerAsync(
                        userController.text, passwordController.text);
                    if (!context.mounted) return;
                    if (registerSuccess) {
                      Navigator.pop(context);
                      return;
                    }
                    singleResponseMessage(
                        context, "erro", "falha no registro, tente novamente");
                  },
                  child: const Text('Registrar')),
            ],
          ),
        ),
      ),
    );
  }
}
