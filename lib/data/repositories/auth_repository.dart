part of 'repositories.dart';

abstract class AuthRepository {
  Future<bool> login({required String username, required String password});
  Future<ResponseAPI<UserResponse>> loginEmailandPassword(
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
  Future<ResponseAPI<UserResponse>> loginEmailandPassword(
      {required UserCredential userCredential}) async {
    final json = await DioNetworkAuth().loginWithEmailPassword(
      endpoint: ApiEndpoint.login,
      userCredential: userCredential,
    );
    if (json.data['code'] == 200 && json.data['status'] == true) {
      final user = UserResponse.fromJson(json.data['user']);
      debugPrint('AUTH CODENYA: ${json.data['code']}');
      debugPrint('AUTH STATUSNYA: ${json.data['status']}');
      return ResponseAPI(message: json.data['message'], data: user);
    } else {
      return ResponseAPI(
        message: json.data['message'],
        error: jsonEncode(json.data['errors']),
        status: json.data['status'],
        statusCode: json.data['code'],
      );
    }
  }
}
