import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../utils/utils.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial());

  Locale locale = const Locale('en', '');

  void setLanguage(Locale value) async {
    try {
      emit(LanguageLoading());
      locale = value;
      await LanguageStorage.setCode(value: value.languageCode);
      await LanguageStorage.setCountryCode(value: value.countryCode ?? '');
      emit(ChangeLanguageSuccess());
    } catch (e) {
      emit(LanguageFailure(message: e.toString()));
    }
  }
}
