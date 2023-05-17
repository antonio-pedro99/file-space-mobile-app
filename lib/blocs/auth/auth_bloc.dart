import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:space_client_app/data/models/auth/user_login.dart';
import 'package:space_client_app/data/models/auth/user_register.dart';
import 'package:space_client_app/data/repository/auth.dart';
import 'package:space_client_app/extensions.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationUser authRepository;

  AuthBloc({required this.authRepository}) : super(LoginInitial()) {
    on<AuthEvent>((event, emit) async {
      var prefs = await SharedPreferences.getInstance();

      if (event is Login) {
        if (!event.email.isEmail()) {
          emit(AuthError("Invalid email"));
        } else {
          emit(AuthLoading());
          var result = await authRepository.signIn(
              UserLoginModel(password: event.password, email: event.email));
          if (result.status!) {
            prefs.setBool("status", result.status!);
            emit(AuthLoaded(event.email));
          } else {
            emit(AuthError(result.message ?? "Failed with unknown error"));
          }
        }
      } else if (event is Signup) {
        if (!event.email.isEmail()) {
          emit(AuthError("Provide a valid email"));
        } else if (!event.password.isPasswordStrong()) {
          emit(AuthError("Provide a Strong password"));
        } else {
          emit(AuthLoading());
          var result = await authRepository.signUp(UserSignUpModel(
              password: event.password, email: event.email, name: event.name));
          if (result.status!) {
            emit(AuthLoaded(event.email));
          } else {
            emit(AuthError(result.message ?? "Failed with unknown error"));
          }
        }
      } /* else if (event is ConfirmSignup) {
        emit(AuthLoading());
        var result = await authRepository.confirm(event.email, event.code);

        if (!result["status"]) {
          emit(AuthError(result["message"]));
        } else {
          emit(AuthLoaded(event.email));
        }
      } else if (event is Logout) {
        emit(AuthLoading());
        var result = await authRepository.signOut();
        if (!result["status"]) {
          emit(AuthError(result["message"]));
        } else {
          prefs.setBool("status", false);
          emit(AuthLoaded(""));
        }
      } */
    });
  }
}
