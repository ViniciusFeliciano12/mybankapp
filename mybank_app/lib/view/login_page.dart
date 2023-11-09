import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:mybank_app/bloc/login_page/login_bloc.dart';
import 'package:mybank_app/bloc/login_page/login_event.dart';
import 'package:mybank_app/bloc/login_page/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  bool passwordObscure = true;
  IconData icon = Icons.remove_red_eye_outlined;

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
        body: SingleChildScrollView(
          child: Stack(clipBehavior: Clip.hardEdge, children: [
            Image.asset("assets/background.jpg").blurred(blur: 0.8),
            _body(context),
          ]),
        ));
  }

  Center _body(BuildContext context) {
    return Center(
      child: BlocBuilder<LoginBloc, LoginState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is LoginLoadingState) {
            return loginLoading();
          }
          if (state is LoginInitialState) {
            return loginInitial(context);
          }
          return Container();
        },
      ),
    );
  }

  Padding loginInitial(BuildContext context) {
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
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              labelText: 'Usuário',
            ),
            controller: userController,
          ),
          const SizedBox(height: 19),
          TextField(
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      passwordObscure = !passwordObscure;
                      if (icon == Icons.remove_red_eye_outlined) {
                        setState(() {
                          icon = Icons.remove_red_eye_rounded;
                        });
                      } else {
                        setState(() {
                          icon = Icons.remove_red_eye_outlined;
                        });
                      }
                    });
                  },
                  icon: Icon(icon)),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              labelText: 'Senha',
            ),
            controller: passwordController,
            obscureText: passwordObscure,
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
              onPressed: () {
                bloc.add(TryLoginEvent(
                    context: context,
                    username: userController.text,
                    password: passwordController.text));
                userController.clear();
                passwordController.clear();
              },
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text('Login'),
              )),
          const SizedBox(height: 5),
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
              onPressed: () {
                bloc.add(GoToRegisterEvent(context: context));
              },
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text('Register'),
              )),
        ],
      ),
    );
  }

  Padding loginLoading() {
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
