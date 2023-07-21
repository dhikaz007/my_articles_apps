import 'package:dio/dio.dart';

import 'dio_network.dart';

class DioNetworkArticles {
  Future<Response> getArticles({required String endpoint}) async {
    final response = await DioNetwork.dio.get(
      endpoint,
      data: {
        "userName": "rachman",
        "password": "testing",
        "usernameOrEmail": "string",
        'token': 'lsGPLl4k6Vc4J0VhnFaMBqetNtn1ofsB',
      },
    );
    return response;
  }
}
