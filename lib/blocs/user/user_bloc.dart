import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:space_client_app/data/models/user.dart';
import 'package:space_client_app/data/repository/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userAttr = UserRepository();
  UserAuthDetails user = UserAuthDetails();
  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is LoadUserSession) {
        if (event.isSigned) {
          emit(UserLoading());
          await _userAttr.fetchCurrentUserAttributes();
          user = UserAuthDetails.fromAttr(_userAttr.user);
          emit(UserLoaded());
        } else {
          emit(UserLoadingError());
        }
      }
    });
  }
}
