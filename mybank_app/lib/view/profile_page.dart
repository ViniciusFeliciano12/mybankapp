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
    bloc = ProfileBloc();
    bloc.add(InitPageEvent(context: context, usuario: usuario));
  }

  @override
  void dispose() {
    _restService.removeListener(callUser);
    super.dispose();
  }

  Center _body() {
    return Center(
      child: BlocBuilder<ProfileBloc, ProfileState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is ProfileSuccessState) {
            return Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.only(top: 8),
              child: ListView(
                children: [
                  const ListTile(
                      leading: Icon(
                        Icons.account_circle_outlined,
                        color: Colors.teal,
                        size: 35,
                      ),
                      title: Text(
                        "Conta",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      )),
                  const SizedBox(height: 15),
                  Container(
                    height: 2,
                    color: Colors.grey,
                  ),
                  ListTile(
                      tileColor: const Color.fromARGB(255, 240, 239, 239),
                      contentPadding: const EdgeInsets.all(8),
                      leading: const Icon(
                          color: Colors.teal, Icons.app_registration_outlined),
                      title: Text("Login da conta: ${usuario!.username}")),
                  Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                  ListTile(
                      tileColor: const Color.fromARGB(255, 240, 239, 239),
                      contentPadding: const EdgeInsets.all(8),
                      leading: const Icon(
                          color: Colors.teal, Icons.add_to_home_screen_rounded),
                      title: Text(
                          "Nome de usuário: ${usuario!.usuario!.nome} ${usuario!.usuario!.sobrenome}")),
                  Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                  ListTile(
                      tileColor: const Color.fromARGB(255, 240, 239, 239),
                      contentPadding: const EdgeInsets.all(8),
                      leading:
                          const Icon(color: Colors.teal, Icons.pix_rounded),
                      title: Text(
                          "PIX de usuário: ${usuario!.usuario!.nome} ${usuario!.usuario!.sobrenome}")),
                  Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                  ListTile(
                    tileColor: const Color.fromARGB(255, 240, 239, 239),
                    iconColor: Colors.teal,
                    leading: const Icon(Icons.credit_card),
                    title: const Text("Tem cartão de crédito?"),
                    subtitle:
                        Text(usuario!.usuario!.cartao == null ? "Não" : "Sim"),
                  ),
                  Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                  ListTile(
                    tileColor: const Color.fromARGB(255, 240, 239, 239),
                    leading:
                        const Icon(color: Colors.teal, Icons.money_outlined),
                    title: const Text("Tem fatura aberta?"),
                    subtitle:
                        Text(usuario!.usuario!.cartao == null ? "Não" : "Sim"),
                  ),
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
                          editAccount(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text('Editar nome do login e senha'),
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
                          editUsername(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text('Editar nome de usuário'),
                        )),
                  ),
                ],
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

  Future<dynamic> editUsername(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          TextEditingController nameController = TextEditingController();
          TextEditingController secondNameController = TextEditingController();
          TextEditingController passwordController = TextEditingController();

          nameController.text = usuario!.usuario!.nome;
          secondNameController.text = usuario!.usuario!.sobrenome;

          return StatefulBuilder(builder: (context, dialogSetState) {
            return AlertDialog(
              title: const Text("Editar usuário"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      bloc.add(EditUserEvent(
                          context: context,
                          name: nameController.text,
                          secondName: secondNameController.text,
                          password: passwordController.text));
                    },
                    child: const Text("Editar usuário"))
              ],
              content: Container(
                width: 600,
                height: 250,
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      const Text("Insira seu nome: "),
                      TextField(controller: nameController),
                      const SizedBox(height: 30),
                      const Text("Insira seu sobrenome:"),
                      TextField(
                        controller: secondNameController,
                      ),
                      const SizedBox(height: 30),
                      const Text("Senha:"),
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

  Future<dynamic> editAccount(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController confirmNewPasswordController =
        TextEditingController();
    bool passwordObscure = true;
    bool newPasswordObscure = true;
    bool confirmPasswordObscure = true;
    nameController.text = usuario!.username;
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, dialogSetState) {
            return AlertDialog(
              title: const Text("Editar conta"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      bloc.add(
                        EditAccountEvent(
                            context: context,
                            username: nameController.text,
                            password: passwordController.text,
                            newPassword: newPasswordController.text,
                            confirmNewPassword:
                                confirmNewPasswordController.text),
                      );
                    },
                    child: const Text("Editar conta"))
              ],
              content: Container(
                width: 600,
                height: 450,
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                          style: TextStyle(color: Colors.red),
                          'Deixe os campos de nova senha em branco caso não queira altera-las'),
                      const SizedBox(height: 30),
                      const Text("Insira seu novo usuário: "),
                      TextField(controller: nameController),
                      const SizedBox(height: 30),
                      const Text("Insira sua senha atual:"),
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
                                dialogSetState(() {
                                  passwordObscure = !passwordObscure;
                                });
                              },
                              icon: const Icon(Icons.remove_red_eye_outlined))
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Text("Insira nova senha desejada:"),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: newPasswordController,
                              obscureText: newPasswordObscure,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                dialogSetState(() {
                                  newPasswordObscure = !newPasswordObscure;
                                });
                              },
                              icon: const Icon(Icons.remove_red_eye_outlined))
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Text("Repita nova senha desejada:"),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: confirmNewPasswordController,
                              obscureText: confirmPasswordObscure,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                dialogSetState(() {
                                  confirmPasswordObscure =
                                      !confirmPasswordObscure;
                                });
                              },
                              icon: const Icon(Icons.remove_red_eye_outlined))
                        ],
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
      drawer: const NavDrawer(index: 1),
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: const Text("Profile page"),
      ),
      body: _body(),
    );
  }
}
