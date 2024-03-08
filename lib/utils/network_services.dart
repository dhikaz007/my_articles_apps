part of 'utils.dart';

mixin NetworkServices {
  final _options = BaseOptions(
    baseUrl: AppUrl.baseUrl,
    connectTimeout: const Duration(seconds: 120),
    receiveTimeout: const Duration(seconds: 120),
  );

  Future<Dio> dio() async {
    final Dio dio = Dio(_options);

    dio.interceptors.add(PrettyDioLogger());

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) {
          request.headers['Accept'] = 'application/json';
          const String token = 'lsGPLl4k6Vc4J0VhnFaMBqetNtn1ofsB';
          request.headers['Authorization'] = 'Bearer $token';
          return handler.next(request);
        },
        onError: (error, handler) {
          if (error.response?.statusCode == 401) {
            debugPrint('ERROR DISINI');
          }
          Modular.to.navigate('/login');
        },
        onResponse: (response, handler) {
          if (response.statusCode == 200 || response.statusCode == 201) {
            debugPrint('RESPONSE CLEAR');
          }
        },
      ),
    );

    return dio;
  }
}
