import 'package:flutter/widgets.dart';

abstract class RegisterEvent {}

class TryRegisterEvent extends RegisterEvent {
  BuildContext context;
  String username;
  String password;
  String confirmPassword;
  TryRegisterEvent(
      {required this.context,
      required this.username,
      required this.password,
      required this.confirmPassword});
}
