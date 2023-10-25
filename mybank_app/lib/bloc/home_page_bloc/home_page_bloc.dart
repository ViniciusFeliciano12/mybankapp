import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybank_app/bloc/home_page_bloc/home_page_event.dart';
import 'package:mybank_app/bloc/home_page_bloc/home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitialState()) {
    on<VerifyUserEvent>((event, emit) async {
      emit(HomePageInitialState());

      emit(event.user == null ? NoValidUserState() : ValidUserState());
    });
  }
}
