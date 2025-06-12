import 'package:com_nectrom_metetemplate/core/managers/logger_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorageManager {
  static final LocalStorageManager instance = LocalStorageManager();

  final LoggerManager _logger = LoggerManager.instance;
  FlutterSecureStorage? _storage;

  LocalStorageManager() {
    _logger.debug('LocalStorageManager başlatıldı');
    initialize();
  }

  Future<void> initialize() async {
    _storage = const FlutterSecureStorage();
  }

  /// [key] anahtarı ile güvenli bir şekilde [value] değerini saklar.
  Future<void> write(String key, String value) async {
    try {
      await _storage!.write(key: key, value: value);
      _logger.debug('[$key] anahtarı için değer güvenli şekilde yazıldı');
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
      rethrow;
    }
  }

  /// [key] anahtarı ile güvenli depolamadan veri okur.
  /// Eğer anahtar yoksa `null` döner.
  Future<String?> read(String key) async {
    try {
      final value = await _storage!.read(key: key);
      _logger.debug('[$key] anahtarından değer okundu');
      return value;
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
      rethrow;
    }
  }

  /// Belirtilen [key] anahtarını güvenli depolamadan siler.
  Future<void> delete(String key) async {
    try {
      await _storage!.delete(key: key);
      _logger.debug('[$key] anahtarı güvenli depolamadan silindi');
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
      rethrow;
    }
  }

  /// Tüm güvenli verileri cihazdan temizler.
  Future<void> deleteAll() async {
    try {
      await _storage!.deleteAll();
      _logger.debug('Tüm veriler güvenli depolamadan silindi');
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
      rethrow;
    }
  }

  /// Tüm güvenli verileri okur ve bir `Map<String, String>` olarak döner.
  Future<Map<String, String>> readAll() async {
    try {
      final data = await _storage!.readAll();
      _logger.debug('Tüm veriler güvenli depolamadan okundu');
      return data;
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
      rethrow;
    }
  }

  /// [key] anahtarının güvenli depolamada mevcut olup olmadığını kontrol eder.
  Future<bool> containsKey(String key) async {
    try {
      final exists = await _storage!.containsKey(key: key);
      _logger.debug('[$key] anahtarı mevcut mu: $exists');
      return exists;
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
      rethrow;
    }
  }
}
