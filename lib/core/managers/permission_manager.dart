import 'package:permission_handler/permission_handler.dart';
import 'logger_manager.dart';

class PermissionManager {
  static final PermissionManager instance = PermissionManager();

  final LoggerManager _logger = LoggerManager.instance;

  PermissionManager() {
    _logger.debug('PermissionManager başlatıldı');
    initialize();
  }

  Future<void> initialize() async {}

  /// Genel amaçlı bir izin isteme fonksiyonudur.
  /// Örnek: `requestPermission(Permission.camera)`
  Future<bool> requestPermission(Permission permission) async {
    try {
      final status = await permission.request();
      return status.isGranted;
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
      return false;
    }
  }

  /// İlgili iznin verilmiş olup olmadığını kontrol eder.
  /// Örnek: `checkPermission(Permission.microphone)`
  Future<bool> checkPermission(Permission permission) async {
    try {
      final status = await permission.status;
      return status.isGranted;
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
      return false;
    }
  }

  /// Kullanıcıya neden izin istenildiğini açıklamak gerekebilir mi sorusunun cevabıdır.
  /// Android'de önemlidir. iOS'ta her zaman false döner.
  Future<bool> shouldShowRequestRationale(Permission permission) async {
    try {
      return await permission.shouldShowRequestRationale;
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
      return false;
    }
  }

  /// Kullanıcı izni kalıcı olarak reddettiyse (permanently denied) true döner.
  /// Bu durumda ayarlar ekranına yönlendirme gerekir.
  Future<bool> isPermanentlyDenied(Permission permission) async {
    try {
      final status = await permission.status;
      return status.isPermanentlyDenied;
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
      return false;
    }
  }

  /// Uygulama ayarları ekranını açar.
  /// Kalıcı olarak reddedilmiş izinler için kullanıcı burada değişiklik yapabilir.
  Future<void> openSettings() async {
    try {
      await openAppSettings();
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
    }
  }

  /// Kamera izni ister
  Future<bool> requestCameraPermission() async => requestPermission(Permission.camera);

  /// Kamera izni durumunu kontrol eder
  Future<bool> checkCameraPermission() async => checkPermission(Permission.camera);

  /// Galeri (fotoğraflar) izni ister
  Future<bool> requestPhotosPermission() async => requestPermission(Permission.photos);

  /// Galeri izni durumunu kontrol eder
  Future<bool> checkPhotosPermission() async => checkPermission(Permission.photos);

  /// Mikrofon izni ister
  Future<bool> requestMicrophonePermission() async => requestPermission(Permission.microphone);

  /// Mikrofon izni durumunu kontrol eder
  Future<bool> checkMicrophonePermission() async => checkPermission(Permission.microphone);

  /// Konum izni ister (foreground)
  Future<bool> requestLocationPermission() async => requestPermission(Permission.location);

  /// Konum izni durumunu kontrol eder
  Future<bool> checkLocationPermission() async => checkPermission(Permission.location);

  /// Bildirim izni ister
  Future<bool> requestNotificationPermission() async => requestPermission(Permission.notification);

  /// Bildirim izni durumunu kontrol eder
  Future<bool> checkNotificationPermission() async => checkPermission(Permission.notification);

  /// Depolama (storage) izni ister
  Future<bool> requestStoragePermission() async => requestPermission(Permission.storage);

  /// Depolama izni durumunu kontrol eder
  Future<bool> checkStoragePermission() async => checkPermission(Permission.storage);

  /// Kişiler izni ister
  Future<bool> requestContactsPermission() async => requestPermission(Permission.contacts);

  /// Kişiler izni durumunu kontrol eder
  Future<bool> checkContactsPermission() async => checkPermission(Permission.contacts);

  /// Takvim izni ister
  Future<bool> requestCalendarPermission() async => requestPermission(Permission.calendar);

  /// Takvim izni durumunu kontrol eder
  Future<bool> checkCalendarPermission() async => checkPermission(Permission.calendar);
}
