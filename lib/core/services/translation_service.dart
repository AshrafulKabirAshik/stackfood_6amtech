import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TranslationService extends Translations {
  static const locale = Locale('en', 'US');
  static const fallbackLocale = Locale('en', 'US');

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          "appTitle": "Flutter Template",
        },
        'bd_BD': {
          "appTitle": "ফ্লাটার টেমপ্লেট",
        },
      };
}
