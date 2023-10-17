import 'package:mybank_app/models/logged_user_dto.dart';

abstract class IRestService {
  //login and register
  Future<bool> loginAsync(String user, String password);
  Future<bool> registerAsync(String user, String password);
  LoggedUserDto? getLoggedInfo();
}
