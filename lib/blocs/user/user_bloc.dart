import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) {
      StreamSubscription<HubEvent> userEvent =
          Amplify.Hub.listen([HubChannel.Auth], (e) {
        switch (e.eventName) {
          case 'SIGNED_IN':
            emit(UserLogged());
            break;
          case 'SIGNED_OUT':
            emit(UserNotLogged());
            break;
          case 'SESSION_EXPIRED':
            emit(UserSessionExpired());
            break;
          case 'USER_DELETED':
            emit(UserDeleted());
            break;
        }
      });
    });
  }
}
