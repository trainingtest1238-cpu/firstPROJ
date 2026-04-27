import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  final _box = GetStorage();
  final _key = 'locale';

  Locale get savedLocale {
    final saved = _box.read<String>(_key);
    if (saved != null) {
      final parts = saved.split('_');
      return Locale(parts[0], parts[1]);
    }
    return const Locale('en', 'US');
  }

  void changeLanguage(String lang, String country) {
    final locale = Locale(lang, country);
    _box.write(_key, '${lang}_$country');
    Get.updateLocale(locale);
  }

  bool get isArabic => Get.locale?.languageCode == 'ar';
}