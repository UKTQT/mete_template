import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutter/foundation.dart';
import 'environment_manager.dart';
import 'logger_manager.dart';

class ErrorManager {
  static final ErrorManager instance = ErrorManager();

  final LoggerManager _logger = LoggerManager.instance;
  late final Map<String, dynamic> _context;

  ErrorManager() {
    _logger.debug('ErrorManager başlatıldı');
    _context = {};

    initialize();
  }

  Future<void> initialize() async {
    /*    if (!EnvironmentManager.isDevelopment) {
      await SentryFlutter.init(
        (options) {
          options.dsn = EnvironmentManager.sentryDsn;
          options.tracesSampleRate = 1.0;
          options.environment = EnvironmentManager.environmentName;
          options.debug = !EnvironmentManager.isProduction;
          // options.beforeSend = _beforeSend;
        },
      );

      _logger.info('Sentry initialized.');
    } else {
      _logger.info('Development modunda, Sentry başlatılmadı.');
    } */
  }

  /// Sentry'ye gönderilmeden önce hata olaylarını filtreler.
  /// Örneğin "ignore" içeren hatalar gönderilmez.
  /* Future<SentryEvent?> _beforeSend(SentryEvent event, {dynamic hint}) async {
    if (event.throwable is String && event.throwable.toString().contains('ignore')) {
      _logger.debug('Ignored error event: ${event.throwable}');
      return null;
    }
    return event;
  } */

  /// Hata raporlarına eklenmek üzere bağlamsal veri ekler.
  void addContext(String key, dynamic value) {
    _context[key] = value;
  }

  /// Bağlamsal veriden bir anahtarı kaldırır.
  void removeContext(String key) {
    _context.remove(key);
  }

  /// Tüm bağlamsal verileri temizler.
  void clearContext() {
    _context.clear();
  }

  /// Exception yakalar ve Sentry'ye bildirir.
  /// Debug modda sadece loglama yapar.
  Future<void> captureException(
    dynamic exception, {
    dynamic stackTrace,
    Hint? hint,
    Map<String, dynamic>? extra,
    SentryLevel level = SentryLevel.error,
    bool forceCapture = false,
  }) async {
    try {
      if (!forceCapture && kDebugMode) {
        _logger.error(exception, tag: 'ERROR');
        return;
      }

      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
        hint: hint,
        withScope: (scope) {
          scope.level = level;
          /* if (hint != null) scope.setTag('hint', hint.);
          if (extra != null) scope.setExtras(extra);
          if (_context.isNotEmpty) scope.setExtras(_context); */
        },
      );
      _logger.info('Exception sent to Sentry: $exception');
    } catch (e) {
      _logger.error('Error while capturing exception', tag: 'ERROR');
    }
  }

  /// Mesaj bazlı log gönderir (exception olmayan durumlar için).
  Future<void> captureMessage(
    String message, {
    SentryLevel level = SentryLevel.info,
    Map<String, dynamic>? extra,
    bool forceCapture = false,
  }) async {
    try {
      if (!forceCapture && kDebugMode) {
        _logger.info(message, tag: 'MESSAGE');
        return;
      }

      await Sentry.captureMessage(
        message,
        level: level,
        withScope: (scope) {
          scope.level = level;
          /* if (extra != null) scope.setExtras(extra);
          if (_context.isNotEmpty) scope.setExtras(_context); */
        },
      );
      _logger.info('Message sent to Sentry: $message');
    } catch (e) {
      _logger.error('Error while capturing message', tag: 'ERROR');
    }
  }

  /// Breadcrumb ekler (hata öncesi işlem adımlarını kaydeder).
  Future<void> addBreadcrumb({
    required String message,
    String? category,
    Map<String, dynamic>? data,
    SentryLevel level = SentryLevel.info,
  }) async {
    try {
      if (kDebugMode) {
        _logger.info('Breadcrumb: $message', tag: 'BREADCRUMB');
        return;
      }

      final breadcrumb = Breadcrumb(
        message: message,
        category: category,
        data: {...?_context, ...?data},
        level: level,
        timestamp: DateTime.now(),
      );

      await Sentry.addBreadcrumb(breadcrumb);
    } catch (e) {
      _logger.error('Error while adding breadcrumb', tag: 'ERROR');
    }
  }

  /// Hatalarla ilişkilendirilecek kullanıcı bilgilerini ayarlar.
  void setUser({
    String? id,
    String? username,
    String? email,
    Map<String, dynamic>? data,
  }) {
    try {
      if (kDebugMode) {
        _logger.info('Set user: $username', tag: 'USER');
        return;
      }

      Sentry.configureScope((scope) {
        scope.setUser(
          SentryUser(
            id: id,
            username: username,
            email: email,
            data: {...?_context, ...?data},
          ),
        );
      });
    } catch (e) {
      _logger.error('Error while setting user', tag: 'ERROR');
    }
  }

  /// Kullanıcı bilgisini temizler.
  void clearUser() {
    try {
      if (kDebugMode) {
        _logger.info('Clear user', tag: 'USER');
        return;
      }

      Sentry.configureScope((scope) => scope.setUser(null));
    } catch (e) {
      _logger.error('Error while clearing user', tag: 'ERROR');
    }
  }
}
