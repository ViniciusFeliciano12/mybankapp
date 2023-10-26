import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:mybank_app/bloc/register_page/register_bloc.dart';
import 'package:mybank_app/bloc/register_page/register_event.dart';
import 'package:mybank_app/bloc/register_page/register_state.dart';

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
            Image.asset("assets/background.jpg").blurred(blur: 0.8),
            _body(context),
          ]),
        ));
  }

  Center _body(BuildContext context) {
    return Center(
      child: BlocBuilder<RegisterBloc, RegisterState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is RegisterLoadingState) {
            return registerLoading();
          }
          if (state is RegisterInitialState) {
            return registerInitial(context);
          }
          return Container();
        },
      ),
    );
  }

  Padding registerInitial(BuildContext context) {
    return Padding(
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
                    userController.clear();
                    passwordController.clear();
                    passwordConfirmController.clear();
                  },
                  child: const Text('Registrar')),
            ),
          ],
        ),
      ),
    );
  }

  Padding registerLoading() {
    return const Padding(
      padding: EdgeInsets.only(top: 150),
      child: Center(
        child: SizedBox(
          height: 250,
          child: LoadingIndicator(
            indicatorType: Indicator.ballClipRotate,
            colors: [Colors.teal],
          ),
        ),
      ),
    );
  }
}
