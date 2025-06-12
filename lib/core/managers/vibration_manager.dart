import 'package:vibration/vibration.dart';
import 'package:com_nectrom_metetemplate/core/managers/logger_manager.dart';

class VibrationManager {
  static final VibrationManager instance = VibrationManager();

  final LoggerManager _logger = LoggerManager.instance;
  bool _hasVibrator = false;

  VibrationManager() {
    _logger.debug('VibrationManager başlatıldı');
    initialize();
  }

  Future<void> initialize() async {
    try {
      _hasVibrator = await Vibration.hasVibrator() ?? false;
      _logger.debug('Cihaz titreşim destekliyor mu? $_hasVibrator');
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
      rethrow;
    }
  }

  Future<void> vibrate({
    int duration = 500,
    List<int>? pattern,
    List<int>? intensities,
  }) async {
    if (!_hasVibrator) {
      _logger.debug('Cihaz titreşimi desteklemiyor.');
      return;
    }

    try {
      if (pattern != null && intensities != null) {
        await Vibration.vibrate(pattern: pattern, intensities: intensities);
        _logger.debug('📳 Titreşim gönderildi (pattern + intensity)');
      } else if (pattern != null) {
        await Vibration.vibrate(pattern: pattern);
        _logger.debug('📳 Titreşim gönderildi (pattern)');
      } else {
        await Vibration.vibrate(duration: duration);
        _logger.debug('📳 Titreşim gönderildi (duration: $duration)');
      }
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
      rethrow;
    }
  }

  Future<void> cancel() async {
    if (!_hasVibrator) return;

    try {
      await Vibration.cancel();
      _logger.debug('Titreşim iptal edildi');
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
      rethrow;
    }
  }

  /// Hazır titreşim türleri
  Future<void> lightVibrate() async => vibrate(duration: 50);
  Future<void> mediumVibrate() async => vibrate(duration: 100);
  Future<void> heavyVibrate() async => vibrate(duration: 200);

  Future<void> successVibrate() async => vibrate(
        pattern: [0, 50, 50, 50],
        intensities: [0, 128, 0, 255],
      );

  Future<void> errorVibrate() async => vibrate(
        pattern: [0, 100, 100, 100],
        intensities: [0, 255, 0, 255],
      );

  Future<void> warningVibrate() async => vibrate(
        pattern: [0, 75, 75, 75],
        intensities: [0, 192, 0, 192],
      );

  Future<void> notificationVibrate() async => vibrate(
        pattern: [0, 100, 100, 100, 100, 100],
        intensities: [0, 255, 0, 128, 0, 255],
      );
}
