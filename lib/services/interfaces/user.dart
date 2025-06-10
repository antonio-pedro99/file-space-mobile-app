import 'package:space_client_app/data/models/user.dart';
import 'package:space_client_app/services/responses/custom_response.dart';

abstract interface class UserManagementService {
  
  Future<ResponseBase> createUser(UserDetails user);
  
  Future<ResponseBase> getUser(String? userId);

  Future<ResponseBase> updateUser(UserDetails user, String? additional);

  Future<ResponseBase> updateStorages(String storageId);

  Future<ResponseBase> uploadProfilePicture(String userId, String filePath);
}