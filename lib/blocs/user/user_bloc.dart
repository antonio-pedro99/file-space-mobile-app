import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) {
      if (event is LoadUserSession) {
        if (event.isSigned) {
          emit(UserLogged());
        } else {
          emit(UserNotLogged());
        }
      }
    });
  }
}
