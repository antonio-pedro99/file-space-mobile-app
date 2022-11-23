part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLogged extends UserState {}

class UserNotLogged extends UserState {}

class UserSignedOut extends UserState {}

class UserSessionExpired extends UserState {}

class UserDeleted extends UserState {}
