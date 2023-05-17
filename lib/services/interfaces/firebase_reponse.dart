import 'package:space_client_app/services/interfaces/custom_response.dart';

class FirebaseResponse extends ResponseBase {
  FirebaseResponse({required bool status, String? message, dynamic data})
      : super(
            status: status,
            message: message,
            data: null,
            statusCode: null,
            error: null);
}
