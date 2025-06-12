import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'environment_manager.dart';

class LoggerManager {
  static final LoggerManager instance = LoggerManager();

  Logger? _logger;

  LoggerManager() {
    initialize();
  }

  Future<void> initialize() async {
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 2, // Hata durumunda gösterilecek method stack sayısı
        errorMethodCount: 8, // Hata loglarında detay stack trace gösterimi
        lineLength: 120, // Log satır uzunluğu sınırı
        colors: true, // Renkli log çıktısı
        printEmojis: true, // Log seviyelerine emoji ekler
      ),
      level: _resolveLogLevel(), // Ortama göre uygun log seviyesi atanır
    );

    _logger!.d('LoggerManager başlatıldı');
  }

  /// Uygulamanın çalışma ortamına göre uygun log seviyesi döner.
  ///
  /// - Development ortamında: `Level.debug`
  /// - Staging ortamında: `Level.info`
  /// - Production ortamında: `Level.warning`
  ///
  /// Varsayılan olarak `Level.info` döner (hiçbir ortam eşleşmezse).
  static Level _resolveLogLevel() {
    if (EnvironmentManager.isDevelopment) {
      return Level.debug;
    }

    if (EnvironmentManager.isStaging) {
      return Level.info;
    }

    if (EnvironmentManager.isProduction) {
      return Level.warning;
    }

    // Beklenmeyen bir ortam durumunda default olarak info seviyesi kullanılır.
    return Level.info;
  }

  /// Debug seviyesinde log mesajı yazdırır (genellikle geliştirme sırasında kullanılır).
  void debug(dynamic message, {dynamic error, StackTrace? stackTrace, String? tag}) => _log(Level.debug, message, error: error, stackTrace: stackTrace, tag: tag);

  /// Bilgilendirme amaçlı log mesajı yazdırır (uygulama akışını takip etmek için kullanılır).
  void info(dynamic message, {dynamic error, StackTrace? stackTrace, String? tag}) => _log(Level.info, message, error: error, stackTrace: stackTrace, tag: tag);

  /// Uyarı seviyesinde log mesajı yazdırır (potansiyel sorunları belirtmek için kullanılır).
  void warning(dynamic message, {dynamic error, StackTrace? stackTrace, String? tag}) => _log(Level.warning, message, error: error, stackTrace: stackTrace, tag: tag);

  /// Hata seviyesinde log mesajı yazdırır (yakalanan istisnalar veya önemli hatalar için kullanılır).
  void error(dynamic message, {dynamic error, StackTrace? stackTrace, String? tag}) => _log(Level.error, message, error: error, stackTrace: stackTrace, tag: tag);

  /// Verilen seviyeye ve etikete göre log mesajı üretir.
  ///
  /// [level]: Log seviyesi (debug, info, warning, error).
  /// [message]: Loglanacak asıl mesaj.
  /// [error]: (Opsiyonel) Hata objesi.
  /// [stackTrace]: (Opsiyonel) Stack trace bilgisi.
  /// [tag]: (Opsiyonel) Log mesajına eklenecek kategori etiketi.
  void _log(
    Level level,
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
    String? tag,
  }) {
    if (!kDebugMode) return;

    final taggedMessage = tag != null ? '[$tag] $message' : message;

    switch (level) {
      case Level.debug:
        _logger!.d(taggedMessage, error: error, stackTrace: stackTrace);
        break;
      case Level.info:
        _logger!.i(taggedMessage, error: error, stackTrace: stackTrace);
        break;
      case Level.warning:
        _logger!.w(taggedMessage, error: error, stackTrace: stackTrace);
        break;
      case Level.error:
        _logger!.e(taggedMessage, error: error, stackTrace: stackTrace);
        break;
      default:
        // Kullanılmayan ya da desteklenmeyen seviyeler için işlem yapılmaz.
        break;
    }
  }
}
