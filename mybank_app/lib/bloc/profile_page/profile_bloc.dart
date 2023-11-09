// ignore_for_file: use_build_context_synchronously

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybank_app/bloc/profile_page/profile_event.dart';
import 'package:mybank_app/bloc/profile_page/profile_state.dart';
import 'package:mybank_app/utils/single_response_message.dart';
import '../../services/interfaces/irest_service.dart';
import '../../services/service_locator.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final IRestService _databaseService = getIt<IRestService>();

  ProfileBloc() : super(ProfileSuccessState()) {
    on<InitPageEvent>((event, emit) async {
      if (event.usuario != null) {
        emit(ProfileSuccessState());
      }
    });

    on<EditAccountEvent>((event, emit) async {
      try {
        if (event.newPassword != event.confirmNewPassword) {
          singleResponseMessage(
              event.context, "Erro", "Senha nova e confirmação são diferentes");
          return;
        }

        if (event.password.isEmpty || event.username.isEmpty) {
          singleResponseMessage(
              event.context, "Erro", "Nenhum campo pode ficar vazio");
          return;
        }

        var response = await _databaseService.editAccountAsync(
            event.username, event.password, event.newPassword);

        if (!event.context.mounted) {
          emit(ProfileSuccessState());
          return;
        }

        if (!response.success) {
          singleResponseMessage(event.context, "Erro", response.message!);
        } else {
          Navigator.pop(event.context);
          singleResponseMessage(event.context, "Sucesso!",
              "Seus dados foram alterados com sucesso.");
        }
        emit(ProfileSuccessState());
      } catch (error) {
        emit(ProfileSuccessState());
        singleResponseMessage(event.context, "Erro", error.toString());
      }
    });

    on<EditUserEvent>((event, emit) async {
      try {
        if (event.password.isEmpty ||
            event.name.isEmpty ||
            event.secondName.isEmpty) {
          singleResponseMessage(
              event.context, "Erro", "Nenhum campo pode ficar vazio");
          return;
        }

        var response = await _databaseService.editUserAsync(
            event.name, event.secondName, event.password);

        if (!event.context.mounted) {
          emit(ProfileSuccessState());
          return;
        }

        if (!response.success) {
          singleResponseMessage(event.context, "Erro", response.message!);
        } else {
          Navigator.pop(event.context);
          singleResponseMessage(event.context, "Sucesso!",
              "Seus dados foram alterados com sucesso.");
        }
        emit(ProfileSuccessState());
      } catch (error) {
        emit(ProfileSuccessState());
        singleResponseMessage(event.context, "Erro", error.toString());
      }
    });
  }
}
