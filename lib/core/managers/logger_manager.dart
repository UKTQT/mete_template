import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'environment_manager.dart';

class LoggerManager {
  static final LoggerManager instance = LoggerManager();

  late final Logger _logger;

  LoggerManager() {
    _logger = Logger(
      printer: SimplePrinter(),
      level: _resolveLogLevel(),
    );

    _logger.d('LoggerManager başlatıldı');

    initialize();
  }

  Future<void> initialize() async {}

  /// Uygulamanın çalışma ortamına göre uygun log seviyesi döner.
  ///
  /// - Development ortamında: `Level.debug`
  /// - Staging ortamında: `Level.info`
  /// - Production ortamında: `Level.warning`
  ///
  /// Varsayılan olarak `Level.info` döner (hiçbir ortam eşleşmezse).
  static Level _resolveLogLevel() {
    if (EnvironmentManager.instance.isDevelopment) return Level.debug;
    if (EnvironmentManager.instance.isStaging) return Level.info;
    if (EnvironmentManager.instance.isProduction) return Level.warning;
    return Level.info;
  }

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
    if (!kDebugMode && level == Level.debug) return;

    final taggedMessage = tag != null ? '[$tag] $message' : message;

    switch (level) {
      case Level.debug:
        _logger.d(taggedMessage, error: error, stackTrace: stackTrace);
        break;
      case Level.info:
        _logger.i(taggedMessage, error: error, stackTrace: stackTrace);
        break;
      case Level.warning:
        _logger.w(taggedMessage, error: error, stackTrace: stackTrace);
        break;
      case Level.error:
        _logger.e(taggedMessage, error: error, stackTrace: stackTrace);
        break;
      default:
        break;
    }
  }

  /// Debug seviyesinde log mesajı yazdırır (genellikle geliştirme sırasında kullanılır).
  void debug(dynamic message, {dynamic error, StackTrace? stackTrace, String? tag}) => _log(Level.debug, message, error: error, stackTrace: stackTrace, tag: tag);

  /// Bilgilendirme amaçlı log mesajı yazdırır (uygulama akışını takip etmek için kullanılır).
  void info(dynamic message, {dynamic error, StackTrace? stackTrace, String? tag}) => _log(Level.info, message, error: error, stackTrace: stackTrace, tag: tag);

  /// Uyarı seviyesinde log mesajı yazdırır (potansiyel sorunları belirtmek için kullanılır).
  void warning(dynamic message, {dynamic error, StackTrace? stackTrace, String? tag}) => _log(Level.warning, message, error: error, stackTrace: stackTrace, tag: tag);

  /// Hata seviyesinde log mesajı yazdırır (yakalanan istisnalar veya önemli hatalar için kullanılır).
  void error(dynamic message, {dynamic error, StackTrace? stackTrace, String? tag}) => _log(Level.error, message, error: error, stackTrace: stackTrace, tag: tag);
}
