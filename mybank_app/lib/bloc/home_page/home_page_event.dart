import 'package:flutter/widgets.dart';

import '../../models/usuario.dart';

abstract class HomePageEvent {}

class VerifyUserEvent extends HomePageEvent {
  BuildContext context;
  Usuario? user;
  VerifyUserEvent({required this.context, this.user});
}

class CreateUserEvent extends HomePageEvent {
  BuildContext context;
  String pix;
  String nome;
  String sobrenome;
  CreateUserEvent(
      {required this.context,
      required this.pix,
      required this.nome,
      required this.sobrenome});
}
