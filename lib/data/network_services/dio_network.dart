part of 'network_services.dart';

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
