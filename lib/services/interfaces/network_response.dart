import 'package:space_client_app/services/interfaces/custom_response.dart';

class NetworkResponse extends ResponseBase {
  NetworkResponse({required bool status, String? message})
      : super(status: status, message: message);
}
