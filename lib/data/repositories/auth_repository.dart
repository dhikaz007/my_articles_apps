import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../dio_network/api_endpoint.dart';
import '../dio_network/dio_network_auth.dart';
import '../model/user_credential.dart';

abstract class AuthRepository {
  Future<bool> login({required String username, required String password});
  Future<ResponseAPI> loginEmailandPassword(
      {required UserCredential userCredential});
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
      return true;
    } else {
      return false;
    }
  }

  //* For method ResponseAPI
  @override
  Future<ResponseAPI> loginEmailandPassword(
      {required UserCredential userCredential}) async {
    final response = await DioNetworkAuth().loginWithEmailPassword(
      endpoint: ApiEndpoint.login,
      userCredential: userCredential,
    );
    if (response.statusCode == 200) {
      debugPrint('AUTH RESPONSE: ${ResponseAPI<Map<String,dynamic>>.fromJson(response.data).toString()}');
      return ResponseAPI<Map<String,dynamic>>.fromJson(response.data);
    } else {
      return ResponseAPI(message: response.statusCode.toString());
    }
  }
}
