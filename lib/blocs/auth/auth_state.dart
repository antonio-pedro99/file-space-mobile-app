part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class LoginInitial extends AuthState {
  LoginInitial();
}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {
  final String email;
  AuthLoaded(this.email);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
