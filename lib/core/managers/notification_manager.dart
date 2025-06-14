import 'dart:io';
import 'package:com_nectrom_metetemplate/core/enums/notification_style_type.dart';
import 'package:com_nectrom_metetemplate/core/managers/logger_manager.dart';
import 'package:com_nectrom_metetemplate/core/utils/app_utils.dart';
import 'package:com_nectrom_metetemplate/core/widgets/snackbar/snackbar_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationManager {
  static final NotificationManager instance = NotificationManager();

  final LoggerManager _logger = LoggerManager.instance;
  FlutterLocalNotificationsPlugin? _notifications;

  NotificationManager() {
    _logger.debug('NotificationManager başlatıldı');
    initialize();
  }

  Future<void> initialize() async {
    try {
      _notifications = FlutterLocalNotificationsPlugin();

      const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
      const iosSettings = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      const settings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      await _notifications!.initialize(
        settings,
        onDidReceiveNotificationResponse: _onNotificationTapped,
      );

      if (Platform.isAndroid) await _createAndroidNotificationChannel();
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
    }
  }

  /// Android cihazlarda yüksek öncelikli bildirim kanalı oluşturur.
  ///
  /// Bu kanal, önemli bildirimlerin kullanıcıya doğru şekilde iletilmesini sağlar.
  /// Kanal ID'si, adı, açıklaması ve öncelik seviyesi belirlenir.
  Future<void> _createAndroidNotificationChannel() async {
    try {
      const channel = AndroidNotificationChannel(
        'high_importance_channel',
        'Yüksek Öncelikli Bildirimler',
        description: 'Bu kanal önemli bildirimler içindir.',
        importance: Importance.high,
      );

      final androidPlugin = _notifications!.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      await androidPlugin?.createNotificationChannel(channel);
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
    }
  }

  /// Bildirime tıklanıldığında tetiklenen geri çağırma fonksiyonu.
  ///
  /// `response` parametresi, bildirime ait bilgiler ve payload içeriğini taşır.
  /// Burada bildirim tıklama olayına bağlı navigasyon veya veri işleme kodları eklenebilir.
  void _onNotificationTapped(NotificationResponse response) {
    try {
      _logger.debug('Bildirim tıklaması: ${response.payload}');
      // TODO: Buraya gerekli yönlendirme işlemleri eklenebilir
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
    }
  }

  /// Android ve iOS için bildirim detaylarını oluşturur.
  ///
  /// Kanal kimliği, adı, açıklaması, öncelik ve diğer platforma özgü ayarları içerir.
  /// Dönen `NotificationDetails` nesnesi, bildirim gösteriminde kullanılır.
  NotificationDetails _notificationDetails() {
    const android = AndroidNotificationDetails(
      'high_importance_channel',
      'Yüksek Öncelikli Bildirimler',
      channelDescription: 'Bu kanal önemli bildirimler içindir.',
      importance: Importance.high,
      priority: Priority.high,
    );

    const ios = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    return const NotificationDetails(android: android, iOS: ios);
  }

  /// Cihazda anlık olarak sistem bildirimi (local notification) gösterir.
  ///
  /// [id]: Bildirimin benzersiz kimliği.
  /// [title]: Bildirim başlığı.
  /// [body]: Bildirim mesaj içeriği.
  /// [payload]: (Opsiyonel) Bildirime özel veri, tıklanınca kullanılabilir.
  Future<void> showSystemNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    try {
      await _notifications!.show(id, title, body, _notificationDetails(), payload: payload);
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
    }
  }

  /// Belirli bir tarihte cihazda sistem bildirimi (local notification) gösterir.
  ///
  /// [id]: Bildirimin benzersiz kimliği.
  /// [title]: Bildirim başlığı.
  /// [body]: Bildirim mesaj içeriği.
  /// [scheduledDate]: Bildirimin gösterileceği tarih ve saat.
  /// [payload]: (Opsiyonel) Bildirime özel veri, tıklanınca kullanılabilir.
  /* Future<void> scheduleSystemNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    try {
      await _notifications!.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledDate, tz.local),
        _notificationDetails(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        payload: payload,
      );
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
    }
  } */

  /// Belirli aralıklarla tekrarlayan sistem bildirimi (local notification) gösterir.
  ///
  /// [id]: Bildirimin benzersiz kimliği.
  /// [title]: Bildirim başlığı.
  /// [body]: Bildirim mesaj içeriği.
  /// [repeatInterval]: Bildirimin tekrar aralığı (saatlik, günlük vb.).
  /// [payload]: (Opsiyonel) Bildirime özel veri, tıklanınca kullanılabilir.
  /* Future<void> showPeriodicSystemNotification({
    required int id,
    required String title,
    required String body,
    required RepeatInterval repeatInterval,
    String? payload,
  }) async {
    try {
      await _notifications!.periodicallyShow(
        id,
        title,
        body,
        repeatInterval,
        _notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
      );
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
    }
  } */

  Future<void> cancelNotification(int id) async {
    try {
      await _notifications!.cancel(id);
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
    }
  }

  Future<void> cancelAllNotifications() async {
    try {
      await _notifications!.cancelAll();
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
    }
  }

  void showInAppSnackbar({
    required NotificationStyleType notificationStyleType,
    required String text,
    Duration? duration,
    bool? isDismissible,
    int? maxLines,
    SnackBarAction? action,
    SnackBarBehavior? behavior,
    VoidCallback? onTap,
  }) {
    try {
      final context = AppUtils.instance.context!;
      final scaffoldMessenger = AppUtils.instance.scaffoldMessengerKey.currentState!;

      final snackbar = snackBarWidget(
        context: context,
        onTap: onTap,
        icon: Icon(notificationStyleType.icon),
        title: 'notificationManager.informationsText'.tr(),
        text: text,
        bgColor: notificationStyleType.backgroundColor,
        duration: duration,
        isDismissible: isDismissible ?? true,
        maxLines: maxLines ?? 3,
        action: action,
        behavior: behavior,
      );

      scaffoldMessenger.showSnackBar(snackbar);
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
    }
  }
}
