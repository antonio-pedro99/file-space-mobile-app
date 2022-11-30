part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class Login extends AuthEvent {
  final String email;
  final String password;

  Login(this.email, this.password);
}

class Signup extends AuthEvent {
  final String name, email, password;

  Signup({required this.email, required this.name, required this.password});
}

class Logout extends AuthEvent {

}

class ConfirmSignup extends AuthEvent {
  final String code;
  final String email;

  ConfirmSignup(this.code, this.email);
}
