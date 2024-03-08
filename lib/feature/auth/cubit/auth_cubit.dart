import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/model/model.dart';
import '../domain/services/services.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final AuthServices _authServices = AuthServices();

  void login({required UserCredential userCredential}) async {
    try {
      emit(AuthLoading());
      final responseAPI = await _authServices.login(credential: userCredential);
      emit(AuthAuthenticated(
          message: responseAPI.message ?? '', userResponse: responseAPI.data));
    } catch (e) {
      emit(AuthError(errorMessage: e.toString()));
    }
  }
}
