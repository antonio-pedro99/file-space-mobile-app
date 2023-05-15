import 'package:firebase_core/firebase_core.dart';
import 'package:space_client_app/data/models/auth/user_login.dart';
import 'package:space_client_app/data/models/auth/user_register.dart';

class AuthenticationUser {
  bool isSignedIn = false;
  bool isSignedUp = false;

  Future<Map<String, dynamic>> signIn(UserLoginModel userDetails) async {
    return {"status": true, "message": "Success!"};
  }

  //aws signup and save UserDetails on Metadata DB
  Future<Map<String, dynamic>> signUp(UserSignUpModel userDetails) async {
    return {"status": true, "message": "Success!"};
  }

  Future<Map<String, dynamic>> signOut() async {
    return {"status": true, "message": "logged out"};
  }

  Future<Map<String, dynamic>> confirm(String email, String code) async {
    return {"status": true, "message": "Confirmed"};
  }

  Future<void> authSignIn(UserLoginModel loginDetails) async {}
}
