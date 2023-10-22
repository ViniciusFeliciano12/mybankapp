import 'package:flutter/widgets.dart';

abstract class LoginEvent {}

class TryLoginEvent extends LoginEvent {
  BuildContext context;
  String username;
  String password;
  TryLoginEvent(
      {required this.context, required this.username, required this.password});
}

class GoToRegisterEvent extends LoginEvent {
  BuildContext context;

  GoToRegisterEvent({required this.context});
}
