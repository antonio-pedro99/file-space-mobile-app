import 'package:space_client_app/data/models/auth/user_login.dart';
import 'package:space_client_app/data/models/auth/user_register.dart';
import 'package:space_client_app/services/interfaces/auth.dart';
import 'package:space_client_app/services/interfaces/custom_response.dart';

class AuthRepository {
  bool isSignedIn = false;
  bool isSignedUp = false;

  final AuthService authService;

  AuthRepository(this.authService);

  Future<ResponseBase> signIn(UserLoginModel login) async {
    return await authService.login(login);
  }

  Future<ResponseBase> signUp(UserSignUpModel user) async {
    return await authService.register(user);
  }

  Future<ResponseBase> logout(String email, String password) async {
    return await authService
        .logout();
  }

  Future<ResponseBase> signOut() async {
    return await authService.logout();
  }

  Future<ResponseBase> confirm() async {
    return await authService.confirm();
  }
}
