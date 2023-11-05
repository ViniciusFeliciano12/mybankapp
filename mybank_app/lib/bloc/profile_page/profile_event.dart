import 'package:flutter/widgets.dart';

import '../../models/logged_user_dto.dart';

abstract class ProfileEvent {}

class InitPageEvent extends ProfileEvent {
  BuildContext context;
  LoggedUserDto? usuario;
  InitPageEvent({required this.context, required this.usuario});
}
