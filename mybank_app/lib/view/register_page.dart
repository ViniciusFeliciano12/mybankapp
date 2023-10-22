import 'package:flutter/material.dart';
import 'package:mybank_app/bloc/register_page/register_bloc.dart';
import 'package:mybank_app/bloc/register_page/register_event.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  late final RegisterBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = RegisterBloc();
  }

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
                    bloc.add(TryRegisterEvent(
                        context: context,
                        username: userController.text,
                        password: passwordController.text));
                  },
                  child: const Text('Registrar')),
            ],
          ),
        ),
      ),
    );
  }
}
