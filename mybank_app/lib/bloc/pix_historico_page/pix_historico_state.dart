import 'package:mybank_app/models/pix_historico.dart';

abstract class PixHistoricoState {
  PixHistoricoState();
}

class PixHistoricoInitialState extends PixHistoricoState {
  PixHistoricoInitialState() : super();
}

class PixHistoricoSuccessState extends PixHistoricoState {
  List<PixHistoricoDto> pixHistorico;
  PixHistoricoSuccessState({required this.pixHistorico}) : super();
}
