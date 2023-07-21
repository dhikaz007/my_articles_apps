import 'package:dio/dio.dart';

class DioNetwork {
  static const String _baseUrl = 'https://demo.treblle.com/api/v1';

  static const Map<String, dynamic> _headers = {
    'Content-Type': 'application/json'
  };

  static const Map<String, dynamic> _queryParam = {'page': 1};

  static final dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      queryParameters: _queryParam,
      headers: _headers,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  );
}
