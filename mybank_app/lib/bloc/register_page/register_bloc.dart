// ignore_for_file: use_build_context_synchronously

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybank_app/bloc/register_page/register_event.dart';
import 'package:mybank_app/bloc/register_page/register_state.dart';
import '../../services/interfaces/irest_service.dart';
import '../../services/service_locator.dart';
import '../../utils/single_response_message.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final IRestService _databaseService = getIt<IRestService>();

  RegisterBloc() : super(RegisterInitialState()) {
    on<TryRegisterEvent>(
      (event, emit) async {
        try {
          emit(RegisterInitialState());
          var response = await _databaseService.registerAsync(
              event.username, event.password);

          if (!event.context.mounted) {
            return;
          }

          if (response.success) {
            Navigator.pop(event.context);
            return;
          } else {
            singleResponseMessage(event.context, "Erro", response.message!);
          }
        } catch (error) {
          singleResponseMessage(event.context, "Erro", error.toString());
        }
      },
    );
  }
}
