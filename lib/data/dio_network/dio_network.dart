import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioNetwork {
  static const String _baseUrl = 'https://demo.treblle.com/api/v1';

  static const Map<String, dynamic> _headers = {
    'Content-Type': 'application/json'
  };

  static final dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      headers: _headers,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  )..interceptors.add( //* Add dio Logger
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
}
