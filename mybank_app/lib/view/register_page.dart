import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
              const TextField(),
              const SizedBox(height: 19),
              const Text('Senha: '),
              const SizedBox(height: 3),
              const TextField(),
              const SizedBox(height: 10),
              ElevatedButton(onPressed: () {}, child: const Text('Registrar')),
            ],
          ),
        ),
      ),
    );
  }
}
