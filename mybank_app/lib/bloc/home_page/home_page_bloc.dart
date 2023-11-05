// ignore_for_file: use_build_context_synchronously

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybank_app/bloc/home_page/home_page_event.dart';
import 'package:mybank_app/bloc/home_page/home_page_state.dart';

import '../../services/interfaces/irest_service.dart';
import '../../services/service_locator.dart';
import '../../utils/single_response_message.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitialState()) {
    final IRestService _databaseService = getIt<IRestService>();

    on<VerifyUserEvent>((event, emit) async {
      emit(HomePageInitialState());

      emit(event.user == null ? NoValidUserState() : ValidUserState());
    });

    on<CreateUserEvent>((event, emit) async {
      emit(HomePageInitialState());

      try {
        emit(HomePageLoadingState());

        if (event.nome.isEmpty || event.sobrenome.isEmpty) {
          emit(NoValidUserState());
          singleResponseMessage(event.context, "Erro",
              "todos os dados precisam ser preenchidos!");
          return;
        }

        var response = await _databaseService.createUserAsync(
            event.pix, event.nome, event.sobrenome);

        if (!event.context.mounted) {
          emit(HomePageInitialState());
          return;
        }

        if (response.success) {
          Navigator.of(event.context).pop();
          singleResponseMessage(
              event.context, "Sucesso!", "Usuário criado com sucesso.");
          emit(ValidUserState());
        } else {
          emit(NoValidUserState());
          singleResponseMessage(event.context, "Erro", response.message!);
        }
      } catch (error) {
        emit(NoValidUserState());
        singleResponseMessage(event.context, "Erro", error.toString());
      }
    });
  }
}
