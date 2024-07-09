import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:space_client_app/data/models/user.dart';
import 'package:space_client_app/data/repository/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userAttr = UserRepository();
  UserAuthDetails user = UserAuthDetails();
  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is LoadUserSession) {
        if (event.isSigned) {
          emit(UserLoading());
          //  await userAttr.fetchCurrentUserAttributes();
          //user = UserAuthDetails.fromAttr(userAttr.user);
          final user = userAttr.loadUserDetails();
          print("User: ${user.data!}");
          emit(UserLoaded());
        } else {
          emit(UserLoadingError());
        }
      } else if (event is UpgradeQuotaUser) {
        emit(UserLoading());

        await userAttr.upgradeQuota(user, event.quota!);
        emit(UserLoaded());
      } else if (event is UpdateProfilePhoto) {
        emit(UserLoading());

        await userAttr.updateProfilePhoto(user, event.photoUrl!);
        emit(UserLoaded());
      }
    });
  }
}
