import 'package:space_client_app/data/models/auth/user_login.dart';
import 'package:space_client_app/data/models/auth/user_register.dart';
import 'package:space_client_app/data/models/storage_auth_client.dart';
import 'package:space_client_app/services/responses/custom_response.dart';

abstract interface class AuthService {
  Future<ResponseBase> login(UserLoginModel user);

  Future<ResponseBase> register(UserSignUpModel user);

  Future<ResponseBase> logout();

  Future<ResponseBase> forgotPassword(String email);

  Future<ResponseBase> changePassword(String oldPassword, String newPassword);

  Future<ResponseBase> confirm();
}

abstract interface class AuthStorageService {
  Future<ResponseBase> saveToken(String token);

  Future<ResponseBase> getToken();

  Future<ResponseBase> deleteToken();

  Future<IntegrationStatus> authorize();

  Future<StorageAuthClient> client();

  Future<IntegrationStatus> deauthorize();
}
