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
  IconData userIcon = Icons.remove_red_eye_outlined;
  IconData passwordIcon = Icons.remove_red_eye_outlined;
  IconData confirmPasswordIcon = Icons.remove_red_eye_outlined;

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
      padding: const EdgeInsets.only(top: 200, left: 50, right: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              labelText: 'Usuário',
            ),
            controller: userController,
          ),
          const SizedBox(height: 10),
          TextField(
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      passwordObscure = !passwordObscure;
                      if (passwordIcon == Icons.remove_red_eye_outlined) {
                        setState(() {
                          passwordIcon = Icons.remove_red_eye_rounded;
                        });
                      } else {
                        setState(() {
                          passwordIcon = Icons.remove_red_eye_outlined;
                        });
                      }
                    });
                  },
                  icon: Icon(passwordIcon)),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              labelText: 'Senha',
            ),
            controller: passwordController,
            obscureText: passwordObscure,
          ),
          const SizedBox(height: 10),
          TextField(
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      passwordObscure = !passwordObscure;
                      if (userIcon == Icons.remove_red_eye_outlined) {
                        setState(() {
                          userIcon = Icons.remove_red_eye_rounded;
                        });
                      } else {
                        setState(() {
                          userIcon = Icons.remove_red_eye_outlined;
                        });
                      }
                    });
                  },
                  icon: Icon(userIcon)),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              labelText: 'Confirmar senha',
            ),
            controller: passwordConfirmController,
            obscureText: passwordConfirmObscure,
          ),
          const SizedBox(height: 100),
          ElevatedButton(
              style: const ButtonStyle(
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
              ),
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
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text('Registrar'),
              )),
        ],
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
