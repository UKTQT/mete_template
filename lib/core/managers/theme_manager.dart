import 'package:com_nectrom_metetemplate/core/constants/theme_constants.dart';
import 'package:com_nectrom_metetemplate/core/managers/local_storage_manager.dart';
import 'package:com_nectrom_metetemplate/core/managers/logger_manager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager {
  static final ThemeManager instance = ThemeManager();

  final LoggerManager _logger = LoggerManager.instance;
  final LocalStorageManager _localStorageManager = LocalStorageManager.instance;

  final String _themeKey = 'app_theme_mode';

  ThemeData? systemTheme;

  ThemeManager() {
    _logger.debug('ThemeManager başlatıldı');
    initialize();
  }

  Future<void> initialize() async {
    await systemThemeOperations();
  }

  /// Cihazda tanımlı sistem temalarını kontrol eder ve uygun olanı uygular.
  Future<void> systemThemeOperations() async {
    _logger.debug('Sistem tema işlemleri başlatıldı');

    final themeMap = ThemeConstants.instance.systemThemeMap;

    if (themeMap.isEmpty) {
      _applyTheme('light', ThemeData.light());
      return;
    }

    final String? storedThemeKey = await _localStorageManager.read(_themeKey);

    final String fallbackKey = themeMap.containsKey('light') ? 'light' : themeMap.keys.first;
    final String selectedKey = (storedThemeKey != null && themeMap.containsKey(storedThemeKey)) ? storedThemeKey : fallbackKey;

    _applyTheme(selectedKey, themeMap[selectedKey]!);
  }

  /// Temayı uygular ve kaydeder
  Future<void> _applyTheme(String key, ThemeData theme) async {
    systemTheme = theme;
    // Get.changeTheme(theme); // Aktifleştirmek istersen açabilirsin
    await _localStorageManager.write(_themeKey, key);
    _logger.debug('✅ Tema uygulandı: $key');
  }

  /// Enum ThemeMode destekli okuma
  Future<ThemeMode> get currentThemeMode async {
    final String? stored = await _localStorageManager.read(_themeKey);
    switch (stored) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return ThemeMode.light;
    }
  }

  /// Enum ThemeMode destekli yazma
  /*  Future<void> setThemeMode(ThemeMode mode) async {
    try {
      final key = _themeModeToKey(mode);
      await _localStorageManager.write(_themeKey, key);
      _logger.debug('💾 Tema modu kaydedildi: $key');
      await systemThemeOperations(); // Yeni temayı uygula
    } catch (e, stackTrace) {
      _logger.error('🔴 Tema modu ayarlanırken hata: $e\n$stackTrace');
      rethrow;
    }
  } */
}
