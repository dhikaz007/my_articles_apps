import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/model.dart';
import '../../data/repositories/repositories.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final AuthRepositoryImpl authRepositoryImpl = AuthRepositoryImpl();

  void loginState({required String userName, required String password}) async {
    try {
      emit(AuthLoading());
      final isLogin = await authRepositoryImpl.login(
          username: userName, password: password);
      if (isLogin == true) {
        //emit(const AuthAuthenticated(message: 'Login Successfull'));
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
      final responseAPI = await authRepositoryImpl.loginEmailandPassword(
          userCredential: userCredential);
      emit(AuthAuthenticated(
          message: responseAPI.message, userResponse: responseAPI.data));
    } catch (e) {
      emit(AuthError(errorMessage: e.toString()));
    }
  }
}
