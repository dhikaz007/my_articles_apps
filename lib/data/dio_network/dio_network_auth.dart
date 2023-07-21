import 'package:dio/dio.dart';

import 'dio_network.dart';

class DioNetworkAuth {
  Future<Response> createUser({
    required String endpoint,
    required String username,
    required String password,
  }) async {
    final response = await DioNetwork.dio.post(
      endpoint,
      data: {
        'email': username,
        'password': password,
        'token': 'lsGPLl4k6Vc4J0VhnFaMBqetNtn1ofsB',
      },
    );
    return response;
  }
}
