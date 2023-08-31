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
      queryParameters: {
        'page': 1,
      },
    );
    return response;
  }

  //* For method ResponseAPI
  Future<Response> fetchArticles({required String endpoint}) async {
    final response = await DioNetwork.dio.get(
      endpoint,
      queryParameters: {'page': 1},
    );
    return response;
  }
}
