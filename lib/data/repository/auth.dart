import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:space_client_app/data/models/auth/user_login.dart';
import 'package:space_client_app/data/models/auth/user_register.dart';

class AuthenticationUser {
  bool isSignedIn = false;
  bool isSignedUp = false;

  Future<Map<String, dynamic>> signIn(UserLoginModel userDetails) async {
    try {
      await Amplify.Auth.signIn(
          username: userDetails.email, password: userDetails.password);
    } on AuthException catch (e) {
      return {"status": false, "message": e.message};
    }
    return {"status": true, "message": "Success!"};
  }

  Future<Map<String, dynamic>> signUp(UserSignUpModel userDetails) async {
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
      return {"status": false, "message": e.message};
    }

    return {"status": true, "message": "Success!"};
  }

  Future<Map<String, dynamic>> signOut() async {
    try {
      await Amplify.Auth.signOut();
    } on AuthException catch (e) {
      return {"status": false, "message": e.message};
    }
    return {"status": true, "message": "logged out"};
  }

  Future<Map<String, dynamic>> confirm(String email, String code) async {
    try {
      await Amplify.Auth.confirmSignUp(username: email, confirmationCode: code);
    } on AuthException catch (e) {
      return {"status": false, "message": e.message};
    }
    return {"status": true, "message": "Confirmed"};
  }
}
