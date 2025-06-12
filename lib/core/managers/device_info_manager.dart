import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:com_nectrom_metetemplate/core/managers/logger_manager.dart';

class DeviceInfoManager {
  static final DeviceInfoManager instance = DeviceInfoManager();

  final LoggerManager _logger = LoggerManager.instance;
  DeviceInfoPlugin? _deviceInfo;

  DeviceInfoManager() {
    _logger.debug('DeviceInfoManager başlatıldı');
    initialize();
  }

  Future<void> initialize() async {
    _deviceInfo = DeviceInfoPlugin();
  }

  /// Platforma göre cihaz bilgilerini getirir.
  /// Android, iOS, Windows, Linux ve macOS için farklı methodlar çağrılır.
  Future<Map<String, dynamic>> getDeviceInfo() async {
    try {
      if (Platform.isAndroid) return await _getAndroidInfo();
      if (Platform.isIOS) return await _getIosInfo();
      if (Platform.isWindows) return await _getWindowsInfo();
      if (Platform.isLinux) return await _getLinuxInfo();
      if (Platform.isMacOS) return await _getMacOsInfo();

      return {'platform': 'Unknown'};
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
      rethrow;
    }
  }

  /// Cihazın model bilgisini döner.
  Future<String> getDeviceModel() async {
    try {
      final info = await getDeviceInfo();
      return info['model'] ?? 'Unknown';
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
      rethrow;
    }
  }

  /// Cihazın platformunu döner (Android, iOS, Windows vs.).
  Future<String> getPlatform() async {
    try {
      final info = await getDeviceInfo();
      return info['platform'] ?? 'Unknown';
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
      rethrow;
    }
  }

  /// Cihazın üreticisini (manufacturer) döner.
  Future<String> getManufacturer() async {
    try {
      final info = await getDeviceInfo();
      return info['manufacturer'] ?? 'Unknown';
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
      rethrow;
    }
  }

  /// Cihazın işletim sistemi versiyonunu döner.
  Future<String> getOsVersion() async {
    try {
      final info = await getDeviceInfo();
      switch (info['platform']) {
        case 'Android':
          return info['version'] ?? 'Unknown';
        case 'iOS':
          return info['systemVersion'] ?? 'Unknown';
        case 'Windows':
          return '${info['majorVersion']}.${info['minorVersion']}';
        case 'Linux':
        case 'macOS':
          return info['osRelease'] ?? info['version'] ?? 'Unknown';
        default:
          return 'Unknown';
      }
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
      rethrow;
    }
  }

  /// Cihazın fiziksel mi yoksa emülatör/sanal mı olduğunu kontrol eder.
  Future<bool> isPhysicalDevice() async {
    try {
      final info = await getDeviceInfo();
      return info['isPhysicalDevice'] ?? false;
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
      rethrow;
    }
  }

  /// Cihazın yerel ayar (locale) bilgisini döner.
  String get deviceLocale => Platform.localeName;

  /// Cihazın bulunduğu zaman dilimini (timezone) döner.
  String get deviceTimezone => DateTime.now().timeZoneName;

  /// Android platformunda olup olmadığını kontrol eder.
  bool get isAndroid => Platform.isAndroid;

  /// iOS platformunda olup olmadığını kontrol eder.
  bool get isIOS => Platform.isIOS;

  /// Windows platformunda olup olmadığını kontrol eder.
  bool get isWindows => Platform.isWindows;

  /// macOS platformunda olup olmadığını kontrol eder.
  bool get isMacOS => Platform.isMacOS;

  /// Linux platformunda olup olmadığını kontrol eder.
  bool get isLinux => Platform.isLinux;

  /// Web platformu için varsayılan olarak false döner (çünkü dart:io kullanılamaz).
  bool get isWeb => false;

  /// Mobil platformda olup olmadığını kontrol eder (Android veya iOS).
  bool get isMobile => isAndroid || isIOS;

  /// Masaüstü platformda olup olmadığını kontrol eder (Windows, macOS, Linux).
  bool get isDesktop => isWindows || isMacOS || isLinux;

  /// Android cihaz bilgilerini döner.
  Future<Map<String, dynamic>> _getAndroidInfo() async {
    final androidInfo = await _deviceInfo!.androidInfo;
    return {
      'platform': 'Android',
      'model': androidInfo.model,
      'manufacturer': androidInfo.manufacturer,
      'version': androidInfo.version.release,
      'sdkVersion': androidInfo.version.sdkInt,
      'isPhysicalDevice': androidInfo.isPhysicalDevice,
      'device': androidInfo.device,
      'product': androidInfo.product,
      'board': androidInfo.board,
      'brand': androidInfo.brand,
      'display': androidInfo.display,
      'hardware': androidInfo.hardware,
      'id': androidInfo.id,
      'type': androidInfo.type,
    };
  }

  /// iOS cihaz bilgilerini döner.
  Future<Map<String, dynamic>> _getIosInfo() async {
    final iosInfo = await _deviceInfo!.iosInfo;
    return {
      'platform': 'iOS',
      'model': iosInfo.model,
      'name': iosInfo.name,
      'systemName': iosInfo.systemName,
      'systemVersion': iosInfo.systemVersion,
      'isPhysicalDevice': iosInfo.isPhysicalDevice,
      'identifierForVendor': iosInfo.identifierForVendor,
      'utsname': {
        'sysname': iosInfo.utsname.sysname,
        'nodename': iosInfo.utsname.nodename,
        'release': iosInfo.utsname.release,
        'version': iosInfo.utsname.version,
        'machine': iosInfo.utsname.machine,
      },
    };
  }

  /// Windows cihaz bilgilerini döner.
  Future<Map<String, dynamic>> _getWindowsInfo() async {
    final winInfo = await _deviceInfo!.windowsInfo;
    return {
      'platform': 'Windows',
      'computerName': winInfo.computerName,
      'userName': winInfo.userName,
      'numberOfCores': winInfo.numberOfCores,
      'systemMemoryInMegabytes': winInfo.systemMemoryInMegabytes,
      'majorVersion': winInfo.majorVersion,
      'minorVersion': winInfo.minorVersion,
      'buildNumber': winInfo.buildNumber,
      'productName': winInfo.productName,
      'productId': winInfo.productId,
      'releaseId': winInfo.releaseId,
      'displayVersion': winInfo.displayVersion,
      'deviceId': winInfo.deviceId,
    };
  }

  /// Linux cihaz bilgilerini döner.
  Future<Map<String, dynamic>> _getLinuxInfo() async {
    final linuxInfo = await _deviceInfo!.linuxInfo;
    return {
      'platform': 'Linux',
      'name': linuxInfo.name,
      'version': linuxInfo.version,
      'id': linuxInfo.id,
      'prettyName': linuxInfo.prettyName,
      'machineId': linuxInfo.machineId,
    };
  }

  /// macOS cihaz bilgilerini döner.
  Future<Map<String, dynamic>> _getMacOsInfo() async {
    final macInfo = await _deviceInfo!.macOsInfo;
    return {
      'platform': 'macOS',
      'computerName': macInfo.computerName,
      'hostName': macInfo.hostName,
      'model': macInfo.model,
      'arch': macInfo.arch,
      'kernelVersion': macInfo.kernelVersion,
      'osRelease': macInfo.osRelease,
      'memorySize': macInfo.memorySize,
      'cpuFrequency': macInfo.cpuFrequency,
      'activeCPUs': macInfo.activeCPUs,
      'systemGUID': macInfo.systemGUID,
    };
  }
}
