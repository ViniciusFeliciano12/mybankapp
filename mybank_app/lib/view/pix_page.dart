import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybank_app/bloc/pix_page/pix_bloc.dart';
import 'package:mybank_app/bloc/pix_page/pix_state.dart';
import 'package:mybank_app/models/logged_user_dto.dart';
import 'package:mybank_app/utils/navigation.dart';
import 'package:mybank_app/view/nav_drawer.dart';
import 'package:mybank_app/view/pix_historico.dart';
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
  TextEditingController chavePixController = TextEditingController();
  TextEditingController passwordPixController = TextEditingController();
  TextEditingController valorController = TextEditingController();
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
          if (state is ConfirmPixState) {
            return Column(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("É esse realmente quem quer enviar pix?"),
                      Text(
                          "Nome: ${state.pixResponse.name} ${state.pixResponse.lastName}"),
                      Text("Chave pix: ${state.pixResponse.chavePIX}"),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: ElevatedButton(
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
                        bloc.add(ConfirmPixEvent(
                            context: context,
                            pixKey: state.pixResponse.chavePIX,
                            password: state.password,
                            valor: state.valor));
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text('Confirmar transferência pix'),
                      )),
                ),
              ],
            );
          }
          if (state is SendPixState) {
            return sendPix();
          }
          if (state is PixInitialState) {
            return pixInitial(context);
          }
          return Container();
        },
      ),
    );
  }

  Column sendPix() {
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.only(top: 8),
            child: ListView(
              children: [
                const ListTile(
                    leading: Icon(
                      Icons.pix_outlined,
                      color: Colors.teal,
                      size: 35,
                    ),
                    title: Text(
                      "Pix",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )),
                const SizedBox(height: 15),
                Container(
                  height: 2,
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("Chave PIX do destinatário:"),
                      TextField(
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                        controller: chavePixController,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("Senha da conta:"),
                      TextField(
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                        controller: passwordPixController,
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("Valor a ser transferido:"),
                      TextField(
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                        controller: valorController,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 2,
                  color: Colors.grey,
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: ElevatedButton(
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
                bloc.add(SendPixEvent(
                    context: context,
                    pixKey: chavePixController.text,
                    password: passwordPixController.text,
                    valor: valorController.text));
              },
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text('Realizar transferência pix'),
              )),
        ),
      ],
    );
  }

  Container pixInitial(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.only(top: 8),
      child: ListView(
        children: [
          const ListTile(
              leading: Icon(
                Icons.pix_outlined,
                color: Colors.teal,
                size: 35,
              ),
              title: Text(
                "Pix",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              )),
          const SizedBox(height: 15),
          Container(
            height: 2,
            color: Colors.grey,
          ),
          ListTile(
              tileColor: const Color.fromARGB(255, 240, 239, 239),
              contentPadding: const EdgeInsets.all(8),
              leading:
                  const Icon(color: Colors.teal, Icons.view_compact_outlined),
              title: Text("PIX de usuário: ${usuario!.usuario!.chavePIX}")),
          Container(
            height: 2,
            color: Colors.grey,
          ),
          const SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 16),
            child: ElevatedButton(
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
                  editChavePix(context);
                },
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('Editar chave pix'),
                )),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: ElevatedButton(
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
                  bloc.add(GoToSendPixPageEvent());
                },
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('Realizar transferência pix'),
                )),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: ElevatedButton(
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
                  navigateWithSlideTransition(
                      context, const PixHistoricoPage(), false);
                },
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('Histórico de transferência pix'),
                )),
          ),
        ],
      ),
    );
  }

  Future<dynamic> editChavePix(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          TextEditingController chavePixController = TextEditingController();
          TextEditingController passwordController = TextEditingController();

          return StatefulBuilder(builder: (context, dialogSetState) {
            return AlertDialog(
              title: const Text("Editar chave pix"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      bloc.add(EditPixKeyEvent(
                          context: context,
                          pixKey: chavePixController.text,
                          password: passwordController.text));
                    },
                    child: const Text("Confirmar"))
              ],
              content: Container(
                width: 600,
                height: 200,
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      const Text("Insira sua nova chave PIX: "),
                      TextField(controller: chavePixController),
                      const SizedBox(height: 30),
                      const Text("Senha: "),
                      TextField(
                        controller: passwordController,
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
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
