import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';

part 'theme_state.dart';

enum ThemeEvent { toogleDark, toogleLight }

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.lightTheme) {
    _loadTheme();
  }

  void setDarkTheme(ThemeEvent event) async {
    switch (event) {
      case ThemeEvent.toogleDark:
        emit(ThemeState.darkTheme);
        _saveTheme(true);
        break;
      case ThemeEvent.toogleLight:
        emit(ThemeState.lightTheme);
        _saveTheme(false);
        break;
    }
  }

  Future<void> _saveTheme(bool isDark) async {
    await ThemeStorages.setTheme(isDark);
  }

  Future<void> _loadTheme() async {
    final theme = await ThemeStorages.getTheme();
    emit(theme);
  }
}
