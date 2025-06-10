import 'package:space_client_app/services/responses/custom_response.dart';

abstract interface class StorageService {
  Future<ResponseBase> files();
}
