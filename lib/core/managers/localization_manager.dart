import 'package:com_nectrom_metetemplate/core/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'logger_manager.dart';

class LocalizationManager {
  static final LocalizationManager instance = LocalizationManager();

  final LoggerManager _logger = LoggerManager.instance;

  List<Locale> supportedLocales = [
    const Locale('en', 'US'),
    const Locale('tr', 'TR'),
  ];
  Locale fallbackLocale = const Locale('en', 'US');

  String localePath = 'assets/translations';

  LocalizationManager() {
    _logger.debug('LocalizationManager başlatıldı');
    initialize();
  }

  Future<void> initialize() async {}

  /// Mevcut locale'yi AppUtils içindeki context üzerinden alır.
  Locale get currentLocale {
    final context = AppUtils.instance.context;
    if (context == null) {
      _logger.warning('Context null, fallbackLocale döndürüldü.', tag: 'LOCALIZATION');
      return fallbackLocale;
    }

    final locale = EasyLocalization.of(context)?.locale ?? fallbackLocale;
    _logger.debug('Geçerli locale alındı: ${locale.languageCode}', tag: 'LOCALIZATION');
    return locale;
  }

  /// Locale değiştirir.
  Future<void> setLocale(Locale locale) async {
    final context = AppUtils.instance.context;
    if (context == null) {
      _logger.error('Context null olduğu için locale değiştirilemedi.', tag: 'LOCALIZATION');
      return;
    }

    try {
      if (isSupported(locale)) {
        await EasyLocalization.of(context)?.setLocale(locale);
        _logger.info('Locale değiştirildi: ${locale.languageCode}', tag: 'LOCALIZATION');
      } else {
        _logger.warning('Desteklenmeyen locale: ${locale.languageCode}', tag: 'LOCALIZATION');
      }
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
      rethrow;
    }
  }

  /// Locale destekleniyor mu kontrolü
  bool isSupported(Locale locale) {
    return supportedLocales.contains(locale);
  }
}
