import 'package:googleapis_auth/googleapis_auth.dart';

abstract class StorageAuthClient extends AuthClient {}

class IntegrationStatus {
  bool? isIntegrated;
  dynamic client;

  IntegrationStatus({this.isIntegrated, this.client});

  @override
  String toString() {
    return 'isIntegrated: $isIntegrated, client: $client';
  }
}
