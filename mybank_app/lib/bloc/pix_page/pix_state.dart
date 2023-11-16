import 'package:mybank_app/models/pix_response.dart';

abstract class PixState {
  PixState();
}

class PixInitialState extends PixState {
  PixInitialState() : super();
}

class SendPixState extends PixState {
  SendPixState();
}

class ConfirmPixState extends PixState {
  String password;
  String valor;
  PixResponseDto pixResponse;
  ConfirmPixState(
      {required this.password, required this.valor, required this.pixResponse});
}
