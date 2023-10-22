import 'package:flutter/widgets.dart';

abstract class HomePageEvent {}

class TryLoginEvent extends HomePageEvent {
  BuildContext context;
  String username;
  String password;
  TryLoginEvent(
      {required this.context, required this.username, required this.password});
}

class GoToRegisterEvent extends HomePageEvent {
  BuildContext context;

  GoToRegisterEvent({required this.context});
}
