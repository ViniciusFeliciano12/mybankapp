import 'package:flutter/material.dart';
import 'package:mybank_app/bloc/home_page_bloc/home_page_bloc.dart';
import 'package:mybank_app/bloc/home_page_bloc/home_page_event.dart';
import 'package:mybank_app/models/logged_user_dto.dart';
import 'package:mybank_app/view/nav_drawer.dart';

import '../services/interfaces/irest_service.dart';
import '../services/service_locator.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

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

    bloc.add(VerifyUserEvent(context: context, user: usuario!.usuario));
    setState(() {
      usuario = _restService.getLoggedInfo();
    });
  }

  Center _body() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(usuario == null ? "null" : usuario?.username ?? "null"),
          Text(usuario == null ? "null" : usuario?.password ?? "null"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _body(),
    );
  }
}
