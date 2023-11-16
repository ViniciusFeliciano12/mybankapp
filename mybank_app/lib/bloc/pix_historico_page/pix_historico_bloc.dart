// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybank_app/bloc/pix_page/pix_state.dart';
import '../../services/interfaces/irest_service.dart';
import '../../services/service_locator.dart';
import '../../utils/single_response_message.dart';
import 'pix_historico_event.dart';
import 'pix_historico_state.dart';

class PixHistoricoBloc extends Bloc<PixHistoricoEvent, PixHistoricoState> {
  final IRestService _restService = getIt<IRestService>();

  PixHistoricoBloc() : super(PixHistoricoInitialState()) {
    on<InitPageEvent>((event, emit) async {
      try {
        var response = await _restService.getListPixAsync();

        if (!event.context.mounted) {
          emit(PixHistoricoInitialState());
          return;
        }

        if (!response.success) {
          singleResponseMessage(event.context, "Erro", response.message!);
        } else {
          emit(PixHistoricoSuccessState(
              pixHistorico: _restService.getPixHistorico()!));
          return;
        }
        emit(PixHistoricoInitialState());
      } catch (error) {
        emit(PixHistoricoInitialState());
        singleResponseMessage(event.context, "Erro", error.toString());
      }
    });
  }
}
