import 'package:com_nectrom_metetemplate/core/enums/environment_type.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentManager {
  static late final EnvironmentType _type;

  // Aktif ortam türünü döner (development: geliştirici test ortamı, staging: ön-prod ortamı, production: canlı ortam)
  static EnvironmentType get type => _type;

  // Ortam kontrolleri
  static bool get isDevelopment => _type == EnvironmentType.development;
  static bool get isStaging => _type == EnvironmentType.staging;
  static bool get isProduction => _type == EnvironmentType.production;

  static void init() {
    _type = _fromString(dotenv.env['ENVIRONMENT']);
  }

  // ENVIRONMENT değeri EnvironmentType enum'una dönüştürülür
  static EnvironmentType _fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'staging':
        return EnvironmentType.staging;
      case 'production':
        return EnvironmentType.production;
      case 'development':
      default:
        return EnvironmentType.development;
    }
  }

  // Ortam ismi string olarak döner (UI, loglama vs.)
  static String get environmentName {
    switch (_type) {
      case EnvironmentType.staging:
        return 'Staging';
      case EnvironmentType.production:
        return 'Production';
      case EnvironmentType.development:
        return 'Development';
    }
  }

  // UYGULAMA BİLGİLERİ
  static String get appName => dotenv.env['APP_NAME']!;
  static String get companyName => dotenv.env['COMPANY']!;
  static String get bundleId => dotenv.env['BUNDLE_ID']!;

  // PLATFORM AYARLARI
  static String get environment => dotenv.env['ENVIRONMENT']!;
  static bool get disableSystemSecurityCheck => dotenv.getBool('DISABLE_SYSTEM_SECURITY_CHECK');
  static int get operationSystem => dotenv.getInt('OPERATION_SYSTEM');

  // SÜRÜM AYARLARI
  static String get version => dotenv.env['VERSION']!;
  static String get versionDate => dotenv.env['VERSION_DATE']!;

  // SUNUCU AYARLARI
  static String get serverIp => dotenv.env['SERVER_IP']!;

  // GELİŞTİRİCİ AYARLARI
  static bool get debugShowCheckedBanner => dotenv.getBool('DEBUG_SHOW_CHECKED_BANNER');

  // AĞ BAĞLANTISI VE KONTROL AYARLARI
  static int get networkCheckTimeout => dotenv.getInt('NETWORK_CHECK_TIMEOUT_SECOND');
  static int get networkCheckInterval => dotenv.getInt('NETWORK_CHECK_INTERVAL_SECOND');
  static String get networkFirstCheckUrl => dotenv.env['NETWORK_FIRST_CHECK_URL']!;
  static int get slowConnectionThreshold => dotenv.getInt('SLOW_CONNECTION_THRESHOLD_SECONDS');
  static int get networkDisconnectionCheckInterval => dotenv.getInt('NETWORK_DISCONNECTION_CHECK_INTERVAL_SECONDS');

  // TİTREŞİM AYARLARI
  static int get vibrationDurationShort => dotenv.getInt('VIBRATION_DURATION_SHORT');
  static int get vibrationDurationLong => dotenv.getInt('VIBRATION_DURATION_LONG');
}
