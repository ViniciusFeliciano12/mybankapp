import 'package:flutter/material.dart';
import 'package:mybank_app/models/logged_user_dto.dart';

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
  LoggedUserDto? usuario = null;

  @override
  void initState() {
    setState(() {
      usuario = _restService.getUserLogged();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(usuario == null ? "null" : usuario?.username ?? "null"),
            Text(usuario == null ? "null" : usuario?.password ?? "null"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
