// ignore_for_file: use_build_context_synchronously

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybank_app/bloc/login_page/login_event.dart';
import 'package:mybank_app/bloc/login_page/login_state.dart';
import 'package:mybank_app/utils/navigation.dart';
import 'package:mybank_app/view/home_page.dart';
import 'package:mybank_app/view/register_page.dart';
import '../../services/interfaces/irest_service.dart';
import '../../services/service_locator.dart';
import '../../utils/single_response_message.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final IRestService _databaseService = getIt<IRestService>();

  LoginBloc() : super(LoginInitialState()) {
    on<TryLoginEvent>(
      (event, emit) async {
        try {
          emit(LoginInitialState());
          var response =
              await _databaseService.loginAsync(event.username, event.password);

          if (!event.context.mounted) {
            return;
          }

          if (response.success) {
            navigateWithSlideTransition(
              event.context,
              const MyHomePage(),
            );
          } else {
            singleResponseMessage(event.context, "Erro", response.message!);
          }
        } catch (error) {
          singleResponseMessage(event.context, "Erro", error.toString());
        }
      },
    );

    on<GoToRegisterEvent>((event, emit) async {
      navigateWithSlideTransition(
        event.context,
        const RegisterPage(),
      );
    });
  }
}
