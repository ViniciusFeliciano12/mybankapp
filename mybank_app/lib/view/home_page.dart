import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybank_app/bloc/home_page/home_page_bloc.dart';
import 'package:mybank_app/bloc/home_page/home_page_event.dart';
import 'package:mybank_app/bloc/home_page/home_page_state.dart';
import 'package:mybank_app/models/logged_user_dto.dart';
import 'package:mybank_app/view/nav_drawer.dart';

import '../services/interfaces/irest_service.dart';
import '../services/service_locator.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final IRestService _restService = getIt<IRestService>();

  late HomePageBloc bloc;
  LoggedUserDto? usuario;

  void getUsuario() {
    setState(() {
      usuario = _restService.getLoggedInfo();
    });
  }

  @override
  void initState() {
    super.initState();
    bloc = HomePageBloc();
    _restService.addListener(getUsuario);
    setState(() {
      usuario = _restService.getLoggedInfo();
    });

    bloc.add(VerifyUserEvent(context: context, user: usuario!.usuario));
  }

  @override
  void dispose() {
    _restService.removeListener(getUsuario);
    super.dispose();
  }

  Center _body() {
    return Center(
      child: BlocBuilder<HomePageBloc, HomePageState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is HomePageInitialState) {
            return Container();
          }

          if (state is ValidUserState) {
            return SizedBox.expand(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Center(
                        child: Text(
                      "Página inicial",
                      style: TextStyle(fontSize: 20, color: Colors.teal),
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                        "Dinheiro na conta: ${usuario?.usuario?.dinheiro} reais"),
                  ],
                ),
              ),
            );
          }

          if (state is NoValidUserState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Usuário não criado. Gere um abaixo:"),
                const SizedBox(height: 50),
                ElevatedButton(
                    onPressed: () {
                      criarUsuarioDialog(context);
                    },
                    child: const Text("Gerar conta bancária")),
              ],
            ));
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(usuario == null ? "null" : usuario?.username ?? "null"),
              Text(usuario == null ? "null" : usuario?.password ?? "null"),
            ],
          );
        },
      ),
    );
  }

  Future<dynamic> criarUsuarioDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController sobrenomeController = TextEditingController();
    TextEditingController pixController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Criar usuário"),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    bloc.add(
                      CreateUserEvent(
                          context: context,
                          nome: nameController.text,
                          sobrenome: sobrenomeController.text,
                          pix: pixController.text),
                    );
                  },
                  child: const Text("Criar conta"))
            ],
            content: Container(
              width: 500,
              height: 400,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Insira seu nome: "),
                  TextField(controller: nameController),
                  const SizedBox(height: 30),
                  const Text("Insira seu sobrenome:"),
                  TextField(controller: sobrenomeController),
                  const SizedBox(height: 30),
                  const Text(
                      "Insira chave PIX desejada (deixe em branco para aleatório):"),
                  TextField(controller: pixController),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: true,
      drawerEdgeDragWidth: 150,
      drawer: const NavDrawer(index: 0),
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: const Text("Home page"),
      ),
      body: _body(),
    );
  }
}
