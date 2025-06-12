import 'package:flutter/material.dart';

enum SystemLanguages {
  en(0, Locale('en')),
  tr(1, Locale('tr'));

  final int type;
  final Locale locale;

  const SystemLanguages(this.type, this.locale);

  static SystemLanguages getCurrentTitle(String title) => SystemLanguages.values.firstWhere((element) => element.locale.languageCode == title);

  static SystemLanguages getCurrentType(int type) => SystemLanguages.values.firstWhere((element) => element.type == type);

  static List<Locale> getLocaleList() => SystemLanguages.values.map((e) => e.locale).toList();

  static List<SystemLanguages> getAllData() => SystemLanguages.values;
}
