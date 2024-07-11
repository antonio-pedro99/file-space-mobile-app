import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:space_client_app/data/models/user.dart';
import 'package:space_client_app/data/repository/user.dart';
import 'package:space_client_app/services/user/firebase_user_service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepo = UserRepository(FirebaseUserService());
  UserDetails uDetails = FirebaseUserDetails();
  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is LoadUserSession) {
        if (event.isSigned) {
          emit(UserLoading());
          final fbUser =
              await userRepo.getUser().then((value) => value.data) as User?;
          uDetails = uDetails.fromUser(fbUser!);
          emit(UserLoaded());
        } else {
          emit(UserLoadingError());
        }
      } else if (event is UpdateProfilePhoto) {
        emit(UserLoading());

        await userRepo.uploadProfilePicture("user", event.photoUrl!);
        emit(UserLoaded());
      }
    });
  }
}
