import 'package:space_client_app/data/models/user.dart';
import 'package:space_client_app/services/interfaces/custom_response.dart';

abstract interface class UserManagementService {
  
  Future<ResponseBase> createUser(UserDetails user);
  
  Future<ResponseBase> getUser(String? userId);

  Future<ResponseBase> updateUser(UserDetails user, String? additional);

  Future<ResponseBase> uploadProfilePicture(String userId, String filePath);
}