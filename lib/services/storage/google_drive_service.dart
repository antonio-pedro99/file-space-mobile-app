import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:space_client_app/data/models/storage_auth_client.dart';
import 'package:space_client_app/services/interfaces/auth.dart';
import 'package:space_client_app/services/interfaces/storage.dart';
import 'package:space_client_app/services/responses/custom_response.dart';
import 'package:space_client_app/services/responses/firebase_response.dart';

class GoogleDriveService implements AuthStorageService, StorageService {
  final GoogleSignIn _googleSignIn =
      GoogleSignIn(scopes: [drive.DriveApi.driveScope]);
  late GoogleSignInAccount? googleSignInAccount;
  late drive.DriveApi driveApi;
  final IntegrationStatus integrationStatus = IntegrationStatus();

  @override
  Future<IntegrationStatus> authorize() async {
    googleSignInAccount = await _googleSignIn.signIn();

    if (await _googleSignIn.isSignedIn()) {
      await googleSignInAccount!.authentication;

      integrationStatus.client = await _googleSignIn.authenticatedClient();
      integrationStatus.isIntegrated = true;

      driveApi = drive.DriveApi(integrationStatus.client!);
    } else {
      integrationStatus.isIntegrated = false;
    }

    return integrationStatus;
  }

  @override
  Future<ResponseBase> deleteToken() {
    throw UnimplementedError();
  }

  @override
  Future<ResponseBase> getToken() {
    throw UnimplementedError();
  }

  @override
  Future<ResponseBase> saveToken(String token) {
    throw UnimplementedError();
  }

  @override
  Future<StorageAuthClient> client() {
    throw UnimplementedError();
  }

  @override
  Future<ResponseBase> files() async {
    final response = FirebaseResponse(status: false);
    try {
      var authoization = await _googleSignIn.signIn();

      if (authoization == null) {
        throw Exception("Authorization failed");
      }
  
      dynamic client = await _googleSignIn.authenticatedClient();
      
      driveApi = drive.DriveApi(client);

      var files = await driveApi.files.list();
      
      response.data = files.files;

      response.status = true;
    } on Exception catch (e) {
      response.message = e.toString();
    }

    return response;
  }

  @override
  Future<IntegrationStatus> deauthorize() async {
    try {
      await _googleSignIn.signOut();
      integrationStatus.isIntegrated = false;
    } on Exception catch (e) {
      throw Exception(e);
    }

    return integrationStatus;
  }
}
