part of 'utils.dart';

class ResponseAPI<T> {
  final int? statusCode;
  final bool? status;
  final String message;
  final T? data;

  ResponseAPI({
    this.statusCode,
    this.status,
    required this.message,
    this.data,
  });

  factory ResponseAPI.fromJson(Map<String, dynamic> json) => ResponseAPI(
        statusCode: json['code'],
        status: json['status'],
        message: json['message'],
        data: json['data'],
      );
}
