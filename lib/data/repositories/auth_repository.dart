part of 'repositories.dart';

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
    try {
      final json = await DioNetworkAuth().loginWithEmailPassword(
        endpoint: ApiEndpoint.login,
        userCredential: userCredential,
      );
      if (json.data['code'] != 200 && json.data['status'] != true) {
        debugPrint('AUTH CODENYA: ${json.data['code']}');
      debugPrint('AUTH STATUSNYA: ${json.data['status']}');
        return ResponseAPI(message: json.data['message']);
      }
      return ResponseAPI<Map<String, dynamic>>.fromJson(json.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        return ResponseAPI(
          message: e.response?.data['message'],
          statusCode: 400,
          error: jsonEncode(e.response?.data['errors']),
        );
      } else {
        return ResponseAPI(
          message: "There's something wrong, please try again later",
          statusCode: 500,
        );
      }
    } catch (e) {
      return ResponseAPI(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }
}
