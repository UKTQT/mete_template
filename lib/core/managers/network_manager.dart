import 'dart:async';

import 'package:com_nectrom_metetemplate/core/enums/notification_style_type.dart';
import 'package:com_nectrom_metetemplate/core/managers/logger_manager.dart';
import 'package:com_nectrom_metetemplate/core/managers/notification_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkManager {
  static final NetworkManager instance = NetworkManager();

  final LoggerManager _logger = LoggerManager.instance;
  InternetConnectionChecker? _internetConnectionChecker;
  Timer? _disconnectedTimer;
  bool _isDisconnected = false;

  NetworkManager() {
    _logger.debug('NetworkManager başlatıldı');
    initialize();
  }

  Future<void> initialize() async {
    _internetConnectionChecker = InternetConnectionChecker.createInstance(
      checkTimeout: const Duration(seconds: 3),
      checkInterval: const Duration(seconds: 10),
      addresses: [
        AddressCheckOption(
          uri: Uri.parse("https://www.google.com"),
          timeout: const Duration(seconds: 3),
        ),
      ],
      statusController: StreamController<InternetConnectionStatus>(),
      slowConnectionConfig: const SlowConnectionConfig(
        enableToCheckForSlowConnection: true,
        slowConnectionThreshold: Duration(seconds: 5),
      ),
      requireAllAddressesToRespond: false,
    );

    _logger.debug('Network kontrolcüsü oluşturuldu');
    startListening();
  }

  void startListening() async {
    try {
      _internetConnectionChecker?.onStatusChange.listen((InternetConnectionStatus status) async {
        switch (status) {
          case InternetConnectionStatus.connected:
            await _handleConnected();
            break;
          case InternetConnectionStatus.disconnected:
            _handleDisconnected();
            break;
          case InternetConnectionStatus.slow:
            _handleSlowConnection();
            break;
        }
      });
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
    }
  }

  Future<void> _handleConnected() async {
    _logger.debug('İnternet bağlantısı sağlandı');
    _isDisconnected = false;

    _disconnectedTimer?.cancel();
    _disconnectedTimer = null;
  }

  void _handleDisconnected() {
    if (_isDisconnected) return; // Çoklu tetiklemeyi engelle

    _isDisconnected = true;
    _logger.debug('İnternet bağlantısı kesildi.');

    _showDisconnectedNotification();
    _disconnectedTimer = Timer.periodic(const Duration(seconds: 20), (_) {
      _showDisconnectedNotification();
    });
  }

  void _handleSlowConnection() {
    _logger.debug('🐢 Yavaş internet bağlantısı algılandı');

    NotificationManager.instance.showInAppSnackbar(
      notificationStyleType: NotificationStyleType.warning,
      text: 'networkManager.slowConnectionText'.tr(),
      duration: const Duration(seconds: 5),
    );
  }

  void _showDisconnectedNotification() {
    NotificationManager.instance.showInAppSnackbar(
      notificationStyleType: NotificationStyleType.error,
      text: 'networkManager.networkCheckText'.tr(),
      duration: const Duration(seconds: 5),
      isDismissible: true,
    );
  }

  Future<bool> isConnected() async {
    return await _internetConnectionChecker?.hasConnection ?? false;
  }
}
