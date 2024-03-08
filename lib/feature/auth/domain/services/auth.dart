part of 'services.dart';

sealed class AuthRepository {
  Future<ResponseAPI<UserResponse>> login({UserCredential credential});
}

final class AuthServices with NetworkServices implements AuthRepository {
  @override
  Future<ResponseAPI<UserResponse>> login({UserCredential? credential}) async {
    try {
      Dio http = await dio();

      Response response = await http.post(
        '/auth/logn',
        data: credential?.toJson(),
      );

      final data = response.data;
      UserResponse? user;
      if (data['code'] == 200 && data['status'] == true) {
        user = UserResponse.fromJson(data['user']);
      }
      return ResponseAPI(
        message: data['message'],
        data: user,
      );
    } catch (e) {
      return ResponseAPI(
        message: e.toString(),
        statusCode: 401,
      );
    }
  }
}
