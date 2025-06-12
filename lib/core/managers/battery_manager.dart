import 'package:battery_plus/battery_plus.dart';
import 'package:com_nectrom_metetemplate/core/managers/logger_manager.dart';

class BatteryManager {
  static final BatteryManager instance = BatteryManager();

  final LoggerManager _logger = LoggerManager.instance;
  Battery? _battery;

  BatteryManager() {
    _logger.debug('BatteryManager başlatıldı');
    initialize();
  }

  Future<void> initialize() async {
    _battery = Battery();
  }

  /// Mevcut pil seviyesini döner (0-100)
  Future<int> getBatteryLevel() async {
    try {
      final level = await _battery!.batteryLevel;
      _logger.debug('Pil seviyesi alındı: %$level');
      return level;
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
      rethrow;
    }
  }

  /// Mevcut pil durumunu döner
  Future<BatteryState> getBatteryState() async {
    try {
      final state = await _battery!.batteryState;
      _logger.debug('Pil durumu alındı: $state');
      return state;
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
      rethrow;
    }
  }

  /// Pil durumu değişikliklerini dinler
  Stream<BatteryState> onBatteryStateChanged() => _battery!.onBatteryStateChanged;

  /// Pil seviyesi periyodik olarak okunur
  Stream<int> onBatteryLevelChanged({Duration interval = const Duration(seconds: 30)}) => Stream.periodic(interval).asyncMap((_) async {
        final level = await getBatteryLevel();
        _logger.debug('Periyodik pil seviyesi güncellendi: %$level');
        return level;
      });

  /// Pil durumuna göre kullanıcıya uygun açıklama döner.
  String getBatteryStateDescription(BatteryState state) {
    const descriptions = {
      BatteryState.full: 'Pil tam dolu',
      BatteryState.charging: 'Pil şarj oluyor',
      BatteryState.discharging: 'Pil deşarj oluyor',
      BatteryState.unknown: 'Pil durumu bilinmiyor',
      BatteryState.connectedNotCharging: 'Cihaz bağlı ama şarj olmuyor',
    };

    return descriptions[state] ?? 'Bilinmeyen pil durumu';
  }

  /// Pil seviyesi %15 ve altındaysa kritiktir
  bool isBatteryLevelCritical(int level) => level <= 15;

  /// Pil seviyesi %30 ve altındaysa düşüktür
  bool isBatteryLevelLow(int level) => level <= 30;

  /// Pil seviyesi %30 üstündeyse yeterlidir
  bool isBatteryLevelSufficient(int level) => level > 30;

  /// Cihazın pil durumu eşleşiyor mu?
  Future<bool> isBatteryState(BatteryState expected) async => (await getBatteryState()) == expected;

  /// Cihaz şarj oluyor mu?
  Future<bool> isCharging() => isBatteryState(BatteryState.charging);

  /// Cihazın pili tam dolu mu?
  Future<bool> isFull() => isBatteryState(BatteryState.full);

  /// Cihazın pili deşarj mı oluyor?
  Future<bool> isDischarging() => isBatteryState(BatteryState.discharging);
}
