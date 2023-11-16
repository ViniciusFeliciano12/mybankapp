// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybank_app/bloc/pix_page/pix_event.dart';
import 'package:mybank_app/bloc/pix_page/pix_state.dart';
import '../../services/interfaces/irest_service.dart';
import '../../services/service_locator.dart';
import '../../utils/single_response_message.dart';

class PixBloc extends Bloc<PixEvent, PixState> {
  final IRestService _restService = getIt<IRestService>();

  PixBloc() : super(PixInitialState()) {
    on<InitPageEvent>((event, emit) async {});

    on<EditPixKeyEvent>((event, emit) async {
      try {
        if (event.password.isEmpty && event.pixKey.isEmpty) {
          singleResponseMessage(event.context, "Erro",
              "Preencha com sua senha e a nova chave pix!");
          return;
        }

        if (event.password.isEmpty) {
          singleResponseMessage(
              event.context, "Erro", "Preencha com a sua senha!");
          return;
        }

        if (event.pixKey.isEmpty) {
          singleResponseMessage(
              event.context, "Erro", "Preencha com a sua chave pix!");
          return;
        }

        var response = await _restService.editarChavePixAsync(
            event.pixKey, event.password);

        if (!event.context.mounted) {
          emit(PixInitialState());
          return;
        }

        if (!response.success) {
          singleResponseMessage(event.context, "Erro", response.message!);
        } else {
          Navigator.pop(event.context);
          singleResponseMessage(event.context, "Sucesso!",
              "Sua chave de pix foi alterada com sucesso.");
        }
        emit(PixInitialState());
      } catch (error) {
        emit(PixInitialState());
        singleResponseMessage(event.context, "Erro", error.toString());
      }
    });

    on<GoToSendPixPageEvent>((event, emit) async {
      emit(SendPixState());
    });

    on<SendPixEvent>((event, emit) async {
      if (event.password.isEmpty || event.pixKey.isEmpty) {
        singleResponseMessage(event.context, "Erro",
            "Preencha com sua senha e a nova chave pix!");
        return;
      }
      try {
        var response = await _restService.verificarChavePixAsync(event.pixKey);

        if (!event.context.mounted) {
          emit(PixInitialState());
          return;
        }

        if (!response.success) {
          singleResponseMessage(event.context, "Erro", response.message!);
        } else {
          emit(ConfirmPixState(
              password: event.password,
              valor: event.valor,
              pixResponse: _restService.getPixresponse()!));
          return;
        }
        emit(PixInitialState());
      } catch (error) {
        emit(PixInitialState());
        singleResponseMessage(event.context, "Erro", error.toString());
      }
    });

    on<ConfirmPixEvent>((event, emit) async {
      try {
        var response = await _restService.fazerPixAsync(
            event.pixKey, event.valor, event.password);

        if (!event.context.mounted) {
          emit(PixInitialState());
          return;
        }

        if (!response.success) {
          singleResponseMessage(event.context, "Erro", response.message!);
        } else {
          singleResponseMessage(
              event.context, "Sucesso!", "Pix enviado com sucesso.");
          emit(PixInitialState());
          return;
        }
        emit(PixInitialState());
      } catch (error) {
        emit(PixInitialState());
        singleResponseMessage(event.context, "Erro", error.toString());
      }
    });
  }
}
