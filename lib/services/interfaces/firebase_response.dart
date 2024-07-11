import 'package:space_client_app/services/interfaces/custom_response.dart';

class FirebaseResponse extends ResponseBase {

  
  FirebaseResponse({required bool super.status, super.message, dynamic data})
      : super(
            data: null,
            statusCode: null,
            error: null);
}
