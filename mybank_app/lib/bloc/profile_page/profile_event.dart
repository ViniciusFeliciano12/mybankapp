import 'package:flutter/widgets.dart';

import '../../models/logged_user_dto.dart';

abstract class ProfileEvent {}

class InitPageEvent extends ProfileEvent {
  BuildContext context;
  LoggedUserDto? usuario;
  InitPageEvent({required this.context, required this.usuario});
}

class EditAccountEvent extends ProfileEvent {
  BuildContext context;
  String password;
  String username;
  String newPassword;
  String confirmNewPassword;
  EditAccountEvent(
      {required this.context,
      required this.username,
      required this.password,
      required this.newPassword,
      required this.confirmNewPassword});
}

class EditUserEvent extends ProfileEvent {
  BuildContext context;
  String name;
  String secondName;
  String password;

  EditUserEvent(
      {required this.context,
      required this.name,
      required this.secondName,
      required this.password});
}
