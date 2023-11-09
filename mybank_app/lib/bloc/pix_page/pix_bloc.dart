// ignore_for_file: use_build_context_synchronously

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybank_app/bloc/pix_page/pix_event.dart';
import 'package:mybank_app/bloc/pix_page/pix_state.dart';
import '../../services/interfaces/irest_service.dart';
import '../../services/service_locator.dart';

class PixBloc extends Bloc<PixEvent, PixState> {
  final IRestService _databaseService = getIt<IRestService>();

  PixBloc() : super(PixInitialState()) {
    on<InitPageEvent>((event, emit) async {});
  }
}
