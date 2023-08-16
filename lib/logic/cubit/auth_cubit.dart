import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/auth_repository.dart';

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
        emit(AuthAuthenticated());
      } else {
        emit(const AuthError(
            errorMessage: 'Login failed. Please check your credentials'));
      }
    } catch (e) {
      emit(AuthError(errorMessage: e.toString()));
    }
  }
}
