abstract class ResponseBase {
  String? message;
  bool? status;
  dynamic data;
  dynamic error;
  int? statusCode;

  ResponseBase(
      {this.message, this.status, this.data, this.statusCode, this.error});

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
      'data': data,
      'statusCode': statusCode,
      'error': error
    };
  }

  bool get hasError => error != null;
  bool get hasData => data != null;
}
