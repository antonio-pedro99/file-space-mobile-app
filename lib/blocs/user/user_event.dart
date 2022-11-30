part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class LoadUserSession extends UserEvent {
  final bool isSigned;
  LoadUserSession(this.isSigned);
}
