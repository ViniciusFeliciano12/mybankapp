import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybank_app/bloc/home_page_bloc/home_page_bloc.dart';
import 'package:mybank_app/bloc/home_page_bloc/home_page_event.dart';
import 'package:mybank_app/bloc/home_page_bloc/home_page_state.dart';
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

  @override
  void initState() {
    super.initState();
    bloc = HomePageBloc();
    setState(() {
      usuario = _restService.getLoggedInfo();
    });

    bloc.add(VerifyUserEvent(context: context, user: usuario!.usuario));
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
            return Container();
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
                      bloc.add(CreateUserEvent(
                          context: context,
                          nome: "shiro",
                          pix: "",
                          sobrenome: "azaoi"));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: true,
      drawerEdgeDragWidth: 150,
      drawer: const NavDrawer(index: 0),
      appBar: AppBar(
        title: const Text("Home page"),
      ),
      body: _body(),
    );
  }
}
