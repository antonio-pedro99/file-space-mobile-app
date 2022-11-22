import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:space_client_app/data/models/auth/user_login.dart';
import 'package:space_client_app/data/models/auth/user_register.dart';

class AuthenticationUser {
  bool isSignedIn = false;
  bool isSignedUp = false;

  Future<void> signIn(UserLoginModel userDetails) async {}

  static Future<String> signUp(UserSignUpModel userDetails) async {
    late SignUpResult result;

    try {
      final attr = <CognitoUserAttributeKey, String>{
        CognitoUserAttributeKey.email: userDetails.email,
        CognitoUserAttributeKey.name: userDetails.name
      };

      await Amplify.Auth.signUp(
          username: userDetails.email,
          password: userDetails.password,
          options: CognitoSignUpOptions(userAttributes: attr));
    } on AuthException catch (e) {
      return e.message;
    }

    return "Success!";
  }

  Future<void> signOut() async {}
}
