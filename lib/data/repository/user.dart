import 'package:space_client_app/services/interfaces/custom_response.dart';
import 'package:space_client_app/services/interfaces/user.dart';

import '../models/user.dart';

class UserRepository {
  final UserManagementService firebaseUserService;

  UserRepository(this.firebaseUserService);

  Future<ResponseBase> createUser(UserDetails user) async {
    return await firebaseUserService.createUser(user);
  }

  Future<ResponseBase> getUser({String? userId}) async {
    return await firebaseUserService.getUser(userId);
  }

  Future<ResponseBase> updateUser(UserDetails user, String? additional) async {
    return await firebaseUserService.updateUser(user, additional);
  }

  Future<ResponseBase> uploadProfilePicture(
      String userId, String filePath) async {
    return await firebaseUserService.uploadProfilePicture(userId, filePath);
  }
}
