part of 'network_services.dart';

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
        //'token': 'lsGPLl4k6Vc4J0VhnFaMBqetNtn1ofsB',
      },
    );
    return response;
  }

  //* For method ResponseAPI
  Future<Response> loginWithEmailPassword({
    required String endpoint,
    required UserCredential userCredential,
  }) async {
    await TokenStoreges.setAccessToken(token: DioNetwork._token);
    final response = await DioNetwork.dio.post(
      endpoint,
      data: userCredential.toJson(),
    );
    return response;
  }
}
