part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoaded extends UserState {
  final UserDetails userDetails;

  UserLoaded(this.userDetails);
}

class UserLoading extends UserState {}

class UserLoadingError extends UserState {}
