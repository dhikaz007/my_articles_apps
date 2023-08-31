import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/user_credential.dart';
import '../../data/repositories/auth_repository.dart';
import '../../utils/utils.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepositoryImpl authRepositoryImpl;
  AuthCubit({required this.authRepositoryImpl}) : super(AuthInitial());

  void loginState({required String userName, required String password}) async {
    emit(AuthLoading());
    try {
      final isLogin = await authRepositoryImpl.login(
          username: userName, password: password);
      if (isLogin == true) {
        //emit(AuthAuthenticated());
      } else {
        emit(const AuthError(
            errorMessage: 'Login failed. Please check your credentials'));
      }
    } catch (e) {
      emit(AuthError(errorMessage: e.toString()));
    }
  }

  //* For method ResponseAPI
  void loginEmailandPassword({required UserCredential userCredential}) async {
    try {
      emit(AuthLoading());
      ResponseAPI responseAPI = await authRepositoryImpl.loginEmailandPassword(
          userCredential: userCredential);
      if (responseAPI.statusCode != 200) {
        emit(AuthError(errorMessage: responseAPI.message));
      } else {
        await TokenStoreges.setAccessToken(
            token: 'lsGPLl4k6Vc4J0VhnFaMBqetNtn1ofsB');
        emit(AuthAuthenticated());
      }
    } catch (e) {
      emit(AuthError(errorMessage: e.toString()));
    }
  }
}
