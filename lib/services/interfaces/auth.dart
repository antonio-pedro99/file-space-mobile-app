import 'package:space_client_app/data/models/auth/user_login.dart';
import 'package:space_client_app/data/models/auth/user_register.dart';
import 'package:space_client_app/services/interfaces/custom_response.dart';

abstract interface class AuthService {
  Future<ResponseBase> login(UserLoginModel user);

  Future<ResponseBase> register(UserSignUpModel user);

  Future<ResponseBase> logout();

  Future<ResponseBase> forgotPassword(String email);

  Future<ResponseBase> changePassword(String oldPassword, String newPassword);

  Future<ResponseBase> confirm();
}
