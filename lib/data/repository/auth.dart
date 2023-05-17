import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:space_client_app/data/models/auth/user_login.dart';
import 'package:space_client_app/data/models/auth/user_register.dart';
import 'package:space_client_app/services/interfaces/firebase_reponse.dart';

class AuthenticationUser {
  bool isSignedIn = false;
  bool isSignedUp = false;

  //firebase authentication methods
  Future<FirebaseResponse> signIn(UserLoginModel user) async {
    var firebaseResponse = FirebaseResponse(status: false);

    try {
      var response = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      firebaseResponse.data = response;
      firebaseResponse.status = true;
      firebaseResponse.message = 'User signed in successfully';
      firebaseResponse.statusCode = 200;

      return firebaseResponse;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          firebaseResponse.message = 'No user found for that email.';
          firebaseResponse.statusCode = 404;
          firebaseResponse.error = e;
          break;
        case 'wrong-password':
          firebaseResponse.message = 'Wrong password provided for that user.';
          firebaseResponse.statusCode = 401;
          firebaseResponse.error = e;
          break;
        case 'invalid-email':
          firebaseResponse.message = 'Invalid email provided.';
          firebaseResponse.statusCode = 400;
          firebaseResponse.error = e;
          break;

        case 'user-disabled':
          firebaseResponse.message = 'User disabled.';
          firebaseResponse.statusCode = 400;
          firebaseResponse.error = e;
          break;
        default:
      }

      return firebaseResponse;
    }
  }

  Future<FirebaseResponse> signUp(UserSignUpModel user) async {
    var firebaseResponse = FirebaseResponse(status: false);
    try {
      var response = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      firebaseResponse.data = response;
      firebaseResponse.status = true;
      firebaseResponse.message = 'User signed up successfully';
      firebaseResponse.statusCode = 200;

      return firebaseResponse;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          firebaseResponse.message = 'Email already in use.';
          firebaseResponse.statusCode = 400;
          firebaseResponse.error = e;
          break;

        case 'invalid-email':
          firebaseResponse.message = 'Invalid email provided.';
          firebaseResponse.statusCode = 400;
          firebaseResponse.error = e;
          break;

        case 'operation-not-allowed':
          firebaseResponse.message = 'Operation not allowed.';
          firebaseResponse.statusCode = 400;
          firebaseResponse.error = e;
          break;

        case 'weak-password':
          firebaseResponse.message = 'Weak password.';
          firebaseResponse.statusCode = 400;
          firebaseResponse.error = e;
          break;

        default:
      }

      return firebaseResponse;
    }
  }

  Future<FirebaseResponse> signOut() async {

    var firebaseResponse =   FirebaseResponse(status: false);

    try {
      await FirebaseAuth.instance.signOut();
      firebaseResponse.status = true;
      firebaseResponse.message = 'User signed out successfully';
      firebaseResponse.statusCode = 200;
      firebaseResponse.data = null;
  
      return firebaseResponse;
    } on FirebaseAuthException catch (e) {
      firebaseResponse.message = 'Error signing out';
      firebaseResponse.statusCode = 400;
      firebaseResponse.error = e;
    }

    return firebaseResponse;
  }

  Future<bool> isUserSignedIn() async {
    try {
      await Firebase.initializeApp();
      isSignedIn = true;
      return isSignedIn;
    } catch (e) {
      print(e);
      return isSignedIn;
    }
  }
}
