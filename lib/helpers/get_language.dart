import 'package:flutter/material.dart';

import '../utils/utils.dart';

class GetLanguage {
  static Future<String> currentLanguage() async {
    String code = await LanguageStorage.getCode() ?? 'la';
    String countryCode = await LanguageStorage.getCountryCode() ?? '';

    debugPrint('INI CODENYA');
    debugPrint(code);
    debugPrint(countryCode);

    return '${code}_$countryCode';
  }
}
