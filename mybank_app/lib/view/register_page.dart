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
  final passwordConfirmController = TextEditingController();
  bool passwordObscure = true;
  bool passwordConfirmObscure = true;

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
        body: SingleChildScrollView(
          child: Stack(children: [
            Image.asset("assets/background.jpg"),
            _body(context),
          ]),
        ));
  }

  Center _body(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 200, left: 50),
        child: SizedBox(
          height: 400,
          width: 250,
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(right: 50),
                child: Text('Usuário: '),
              ),
              const SizedBox(height: 3),
              Padding(
                padding: const EdgeInsets.only(right: 50),
                child: TextField(
                  controller: userController,
                ),
              ),
              const SizedBox(height: 19),
              const Padding(
                padding: EdgeInsets.only(right: 50),
                child: Text('Senha: '),
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: passwordController,
                      obscureText: passwordObscure,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          passwordObscure = !passwordObscure;
                        });
                      },
                      icon: const Icon(Icons.remove_red_eye_outlined))
                ],
              ),
              const SizedBox(height: 19),
              const Padding(
                padding: EdgeInsets.only(right: 50),
                child: Text('Confirme a senha: '),
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: passwordConfirmController,
                      obscureText: passwordConfirmObscure,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          passwordConfirmObscure = !passwordConfirmObscure;
                        });
                      },
                      icon: const Icon(Icons.remove_red_eye_outlined))
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(right: 50),
                child: ElevatedButton(
                    onPressed: () async {
                      bloc.add(TryRegisterEvent(
                          context: context,
                          username: userController.text,
                          password: passwordController.text,
                          confirmPassword: passwordConfirmController.text));
                    },
                    child: const Text('Registrar')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
