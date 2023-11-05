import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybank_app/bloc/profile_page/profile_event.dart';
import 'package:mybank_app/bloc/profile_page/profile_state.dart';
import 'package:mybank_app/models/logged_user_dto.dart';
import 'package:mybank_app/view/nav_drawer.dart';

import '../bloc/profile_page/profile_bloc.dart';
import '../services/interfaces/irest_service.dart';
import '../services/service_locator.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final IRestService _restService = getIt<IRestService>();

  late ProfileBloc bloc;
  LoggedUserDto? usuario;

  @override
  void initState() {
    super.initState();
    usuario = _restService.getLoggedInfo();
    bloc = ProfileBloc();
    bloc.add(InitPageEvent(context: context, usuario: usuario));
  }

  Center _body() {
    return Center(
      child: BlocBuilder<ProfileBloc, ProfileState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is ProfileSuccessState) {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox.expand(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Nome de usuário da conta: ${usuario!.username}"),
                    const SizedBox(height: 10),
                    Text(
                        "Nome: ${usuario!.usuario!.nome} ${usuario!.usuario!.sobrenome}"),
                    const SizedBox(height: 10),
                    Text("PIX do usuário: ${usuario!.usuario!.chavePIX}"),
                    const SizedBox(height: 10),
                    const Text("Tem cartão de crédito?"),
                    Text(usuario!.usuario!.cartao == null ? "não" : "sim"),
                    const SizedBox(height: 10),
                    const Text("Tem faturas abertas?"),
                    Text(usuario!.usuario!.cartao == null ? "não" : "sim"),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            );
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
      drawer: const NavDrawer(index: 1),
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: const Text("Profile page"),
      ),
      body: _body(),
    );
  }
}
