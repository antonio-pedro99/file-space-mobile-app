import 'package:space_client_app/data/models/storage_auth_client.dart';
import 'package:space_client_app/services/responses/custom_response.dart';
import 'package:space_client_app/services/storage/google_drive_service.dart';

class GoogleDriveStorageRepository {
  final GoogleDriveService driveService;

  GoogleDriveStorageRepository(this.driveService);

  Future<IntegrationStatus> authorize() async {
    return await driveService.authorize();
  }

  Future<IntegrationStatus> deauthorize() async {
    return await driveService.deauthorize();
  }

  Future<ResponseBase> files() async {
    return await driveService.files();
  }
}
