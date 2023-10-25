part of 'network_services.dart';

class DioNetwork {
  static const String _baseUrl = 'https://demo.treblle.com/api/v1';

  static const String _token = 'lsGPLl4k6Vc4J0VhnFaMBqetNtn1ofsB';

  static const Map<String, dynamic> _headers = {
    'Authorization': 'Bearer $_token',
    'Content-Type': 'application/json',
  };

  static final dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      headers: _headers,
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1),
    ),
  )..interceptors.add(
      //* Add dio Logger
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
}
