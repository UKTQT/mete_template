import 'package:com_nectrom_metetemplate/core/enums/environment_type.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentManager {
  static final EnvironmentManager instance = EnvironmentManager();

  late final EnvironmentType _type;

  EnvironmentManager() {
    _type = _fromString(dotenv.env['ENVIRONMENT']);

    initialize();
  }

  Future<void> initialize() async {}

  // Aktif ortam türünü döner (development: geliştirici test ortamı, staging: ön-prod ortamı, production: canlı ortam)
  EnvironmentType get type => _type;

  // Ortam kontrolleri
  bool get isDevelopment => _type == EnvironmentType.development;
  bool get isStaging => _type == EnvironmentType.staging;
  bool get isProduction => _type == EnvironmentType.production;

  // ENVIRONMENT değeri EnvironmentType enum'una dönüştürülür
  EnvironmentType _fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'staging':
        return EnvironmentType.staging;
      case 'production':
        return EnvironmentType.production;
      case 'development':
        return EnvironmentType.development;
      default:
        return EnvironmentType.development;
    }
  }

  // Ortam ismi string olarak döner (UI, loglama vs.)
  String get environmentName {
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
  String get appName => dotenv.env['APP_NAME']!;
  String get companyName => dotenv.env['COMPANY']!;
  String get bundleId => dotenv.env['BUNDLE_ID']!;

  // PLATFORM AYARLARI
  String get environment => dotenv.env['ENVIRONMENT']!;
  bool get disableSystemSecurityCheck => dotenv.getBool('DISABLE_SYSTEM_SECURITY_CHECK');
  int get operationSystem => dotenv.getInt('OPERATION_SYSTEM');

  // SÜRÜM AYARLARI
  String get version => dotenv.env['VERSION']!;
  String get versionDate => dotenv.env['VERSION_DATE']!;

  // SUNUCU AYARLARI
  String get serverIp => dotenv.env['SERVER_IP']!;

  // GELİŞTİRİCİ AYARLARI
  bool get debugShowCheckedBanner => dotenv.getBool('DEBUG_SHOW_CHECKED_BANNER');

  // AĞ BAĞLANTISI VE KONTROL AYARLARI
  int get networkCheckTimeout => dotenv.getInt('NETWORK_CHECK_TIMEOUT_SECOND');
  int get networkCheckInterval => dotenv.getInt('NETWORK_CHECK_INTERVAL_SECOND');
  String get networkFirstCheckUrl => dotenv.env['NETWORK_FIRST_CHECK_URL']!;
  int get slowConnectionThreshold => dotenv.getInt('SLOW_CONNECTION_THRESHOLD_SECONDS');
  int get networkDisconnectionCheckInterval => dotenv.getInt('NETWORK_DISCONNECTION_CHECK_INTERVAL_SECONDS');

  // TİTREŞİM AYARLARI
  int get vibrationDurationShort => dotenv.getInt('VIBRATION_DURATION_SHORT');
  int get vibrationDurationLong => dotenv.getInt('VIBRATION_DURATION_LONG');
}
