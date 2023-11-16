import 'package:flutter/widgets.dart';

import '../../models/logged_user_dto.dart';

abstract class PixEvent {}

class InitPageEvent extends PixEvent {
  BuildContext context;
  LoggedUserDto? usuario;
  InitPageEvent({required this.context, required this.usuario});
}

class EditPixKeyEvent extends PixEvent {
  BuildContext context;
  String pixKey;
  String password;
  EditPixKeyEvent({
    required this.context,
    required this.pixKey,
    required this.password,
  });
}

class GoToSendPixPageEvent extends PixEvent {
  GoToSendPixPageEvent();
}

class SendPixEvent extends PixEvent {
  BuildContext context;
  String pixKey;
  String password;
  String valor;
  SendPixEvent(
      {required this.context,
      required this.pixKey,
      required this.password,
      required this.valor});
}

class ConfirmPixEvent extends PixEvent {
  BuildContext context;
  String password;
  String pixKey;
  String valor;
  ConfirmPixEvent(
      {required this.context,
      required this.pixKey,
      required this.password,
      required this.valor});
}
