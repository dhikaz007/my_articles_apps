import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'password_visibility_state.dart';

enum PasswordVisibility { visible, hidden }

class PasswordVisibilityCubit extends Cubit<PasswordVisibilityState> {
  PasswordVisibilityCubit()
      : super(const PasswordVisibilityState(isVisible: false));

  void toggleVisibility({required bool isVisible}) {
    emit(PasswordVisibilityState(isVisible: isVisible));
  }

  // void toggleVisibility() {
  //   emit(
  //     state == PasswordVisibility.hidden
  //         ? PasswordVisibility.visible
  //         : PasswordVisibility.hidden,
  //   );
  // }
}
