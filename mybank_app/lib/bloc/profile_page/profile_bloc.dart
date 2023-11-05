// ignore_for_file: use_build_context_synchronously

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybank_app/bloc/profile_page/profile_event.dart';
import 'package:mybank_app/bloc/profile_page/profile_state.dart';
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
  }
}
