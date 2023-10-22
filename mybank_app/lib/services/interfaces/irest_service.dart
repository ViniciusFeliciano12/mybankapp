import 'package:mybank_app/models/logged_user_dto.dart';
import 'package:mybank_app/models/responseDTO.dart';

abstract class IRestService {
  //login and register
  Future<ResponseDTO> loginAsync(String user, String password);
  Future<ResponseDTO> registerAsync(String user, String password);
  LoggedUserDto? getLoggedInfo();
}
