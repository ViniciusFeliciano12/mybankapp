import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybank_app/bloc/pix_page/pix_bloc.dart';
import 'package:mybank_app/bloc/pix_page/pix_state.dart';
import 'package:mybank_app/models/logged_user_dto.dart';
import 'package:mybank_app/view/nav_drawer.dart';
import '../bloc/pix_page/pix_event.dart';
import '../services/interfaces/irest_service.dart';
import '../services/service_locator.dart';

class PixPage extends StatefulWidget {
  const PixPage({super.key});

  @override
  State<PixPage> createState() => _PixPageState();
}

class _PixPageState extends State<PixPage> {
  final IRestService _restService = getIt<IRestService>();

  late PixBloc bloc;
  LoggedUserDto? usuario;

  void callUser() {
    setState(() {
      usuario = _restService.getLoggedInfo();
    });
  }

  @override
  void initState() {
    super.initState();
    usuario = _restService.getLoggedInfo();
    _restService.addListener(callUser);
    bloc = PixBloc();
    bloc.add(InitPageEvent(context: context, usuario: usuario));
  }

  @override
  void dispose() {
    _restService.removeListener(callUser);
    super.dispose();
  }

  Center _body() {
    return Center(
      child: BlocBuilder<PixBloc, PixState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is PixInitialState) {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox.expand(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
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
      drawer: const NavDrawer(index: 2),
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: const Text("Pix page"),
      ),
      body: _body(),
    );
  }
}
