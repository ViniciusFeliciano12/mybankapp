import 'package:get_it/get_it.dart';
import 'package:mybank_app/services/interfaces/irest_service.dart';
import 'package:mybank_app/services/rest_service.dart';

final getIt = GetIt.instance;

setupServiceLocator() {
  getIt.registerLazySingleton<IRestService>(() => RestService());
}
