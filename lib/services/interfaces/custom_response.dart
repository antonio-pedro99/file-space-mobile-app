abstract class ResponseBase {
  final String? message;
  final bool? status;
  final dynamic data;
  final dynamic error;
  final int? statusCode;

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
