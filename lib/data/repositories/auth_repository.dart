import 'package:flutter/material.dart';

import '../dio_network/api_endpoint.dart';
import '../dio_network/dio_network_auth.dart';

abstract class AuthRepository {
  Future<bool> login({required String username, required String password});
}

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<bool> login({
    required String username,
    required String password,
  }) async {
    final data = await DioNetworkAuth().createUser(
      endpoint: ApiEndpoint.login,
      username: username,
      password: password,
    );
    if (data.statusCode == 200) {
      debugPrint('SHOW: ${data.statusCode}');
      return true;
    } else {
      return false;
    }
  }
}
