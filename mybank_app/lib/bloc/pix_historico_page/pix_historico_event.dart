import 'package:flutter/widgets.dart';

import '../../models/logged_user_dto.dart';

abstract class PixHistoricoEvent {}

class InitPageEvent extends PixHistoricoEvent {
  BuildContext context;
  InitPageEvent({required this.context});
}
