part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoaded extends UserState {}

class UserLoading extends UserState {}

class UserLoadingError extends UserState {}
