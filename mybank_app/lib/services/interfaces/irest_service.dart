import 'package:mybank_app/models/logged_user_dto.dart';

abstract class IRestService {
  //login
  Future<bool> loginAsync(String user, String password);
  LoggedUserDto? getUserLogged();
}
