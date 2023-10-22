import 'package:flutter/material.dart';
import 'package:mybank_app/bloc/login_page/login_bloc.dart';
import 'package:mybank_app/bloc/login_page/login_event.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  late final LoginBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = LoginBloc();
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
              TextField(controller: passwordController, obscureText: true),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    bloc.add(TryLoginEvent(
                        context: context,
                        username: userController.text,
                        password: passwordController.text));
                  },
                  child: const Text('Login')),
              ElevatedButton(
                  onPressed: () {
                    bloc.add(GoToRegisterEvent(context: context));
                  },
                  child: const Text('Register')),
            ],
          ),
        ),
      ),
    );
  }
}
