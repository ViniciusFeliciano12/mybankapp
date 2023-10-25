import 'package:flutter/widgets.dart';

import '../../models/usuario.dart';

abstract class HomePageEvent {}

class VerifyUserEvent extends HomePageEvent {
  BuildContext context;
  Usuario? user;
  VerifyUserEvent({required this.context, this.user});
}

class GoToRegisterEvent extends HomePageEvent {
  BuildContext context;

  GoToRegisterEvent({required this.context});
}
