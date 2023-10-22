import 'package:flutter/widgets.dart';

abstract class RegisterEvent {}

class TryRegisterEvent extends RegisterEvent {
  BuildContext context;
  String username;
  String password;
  TryRegisterEvent(
      {required this.context, required this.username, required this.password});
}
