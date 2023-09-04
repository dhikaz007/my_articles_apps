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
        statusCode: json['code'],
        status: json['status'],
        message: json['message'],
        data: json['data'],
        error: json['errors'],
      );
}
