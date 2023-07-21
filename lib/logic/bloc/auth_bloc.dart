import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositoryImpl authRepositoryImpl;
  AuthBloc({required this.authRepositoryImpl}) : super(AuthInitial()) {
    on<AuthLogin>((event, emit) async {
      emit(AuthLoading());
      try {
        final isLogin = await authRepositoryImpl.login(
            username: event.userName, password: event.password);
        if (isLogin == true) {
          emit(AuthAuthenticated());
        } else {
          emit(const AuthError(
              errorMessage: 'Login failed. Please check your credentials'));
        }
      } catch (e) {
        emit(AuthError(errorMessage: e.toString()));
      }
    });
  }

  // void login({required String username, required String password}) async {
  //   emit(AuthLoading());
  //   try {
  //     final isLogin = await authRepositoryImpl.login(
  //         username: username, password: password);
  //     if (isLogin) {
  //       emit(AuthAuthenticated());
  //     } else {
  //       emit(const AuthError(
  //           errorMessage: 'Login failed. Please check your credentials'));
  //     }
  //   } catch (e) {
  //     emit(AuthError(errorMessage: e.toString()));
  //   }
  // }
}
