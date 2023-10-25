part of 'utils.dart';

class ResponseAPI<T> {
  final int? statusCode;
  final bool? status;
  final String message;
  final T? data;
  final String? error;

  ResponseAPI({
    this.statusCode,
    this.status,
    required this.message,
    this.data,
    this.error,
  });

  factory ResponseAPI.fromJson(Map<String, dynamic> json) => ResponseAPI(
        statusCode: json['code'] ?? 0,
        status: json['status'] ?? false,
        message: json['message'] ?? '-',
        data: json['data'] ?? '-',
        error: json['errors'] ?? '-',
      );

  @override
  String toString() {
    return 'ResponseAPI(statusCode: $statusCode, status: $status, message: $message, data: $data, error: $error)';
  }
}
