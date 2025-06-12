import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'logger_manager.dart';

class LocalDbManager {
  static final LocalDbManager instance = LocalDbManager();

  final LoggerManager _logger = LoggerManager.instance;

  // Hive Interface
  HiveInterface? hiveInterface;

  // Hive Boxs
  String appBoxName = "appBox";
  Box<Map<dynamic, dynamic>>? appBox;

  LocalDbManager() {
    _logger.debug('LocalDbManager başlatıldı');
    initialize();
  }

  Future<void> initialize() async {
    try {
      /// Hive init
      final appDocumentDirectory = await getApplicationDocumentsDirectory();
      Hive.init(appDocumentDirectory.path);
      hiveInterface = Hive;

      // Box Open
      appBox = await _openBox(boxName: appBoxName);
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
      rethrow;
    }
  }

  /// Belirtilen isimdeki Hive kutusunu güvenli şekilde açar.
  ///
  /// - Kutu zaten açıksa, mevcut açık kutu nesnesi döndürülür.
  /// - Açık değilse, `hiveInterface.openBox()` ile açılmaya çalışılır.
  /// - Açma işlemi başarısız olursa veya kutu etkin değilse `null` döner.
  ///
  /// [boxName] - Açılması veya erişilmesi istenen kutunun adı.
  Future<Box<Map>?> _openBox({required String boxName}) async {
    try {
      if (Hive.isBoxOpen(boxName)) {
        final existingBox = Hive.box<Map>(boxName);
        _logger.debug('Box zaten açık: $boxName');
        return existingBox;
      }

      if (hiveInterface == null) {
        _logger.error('HiveInterface null olduğu için kutu açılamadı.');
        return null;
      }

      final openedBox = await hiveInterface!.openBox<Map>(boxName);

      if (openedBox.isOpen) {
        _logger.debug('Box "$boxName" başarıyla açıldı.');
        return openedBox;
      } else {
        _logger.debug('Box "$boxName" açıldı ancak etkin değil (isOpen = false).');
      }
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
      rethrow;
    }

    return null;
  }

  /// Verilen kutuya, belirli bir anahtar ile değer ekler veya günceller.
  ///
  /// [boxName] : İşlem yapılacak kutunun adı.
  /// [key] : Eklenecek veya güncellenecek anahtar.
  /// [value] : Anahtar için atanacak değer.
  Future<void> put({required String boxName, dynamic key, dynamic value}) async {
    try {
      if (!Hive.isBoxOpen(boxName)) {
        _logger.error('$boxName kapalı olduğu için yazma işlemi gerçekleştirilemedi');
        return;
      }

      final box = Hive.box<Map>(boxName);
      await box.put(key, value);
      _logger.debug('$boxName içerisine veri yazıldı: key="$key"');
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
      rethrow;
    }
  }

  /// Verilen kutudan, belirli bir anahtara karşılık gelen değeri döner.
  dynamic get({required String boxName, dynamic key, dynamic defaultValue}) {
    try {
      if (!Hive.isBoxOpen(boxName)) {
        _logger.error('$boxName kapalı olduğu için yazma işlemi gerçekleştirilemedi');
        return;
      }

      final box = Hive.box<Map>(boxName);
      final value = box.get(key, defaultValue: defaultValue);
      _logger.debug('$boxName içerisinden veri okundu: key="$key"');
      return value;
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
      rethrow;
    }
  }

  /// Verilen kutudan belirli bir anahtar ile kaydı siler.
  Future<void> delete({required String boxName, dynamic key}) async {
    try {
      if (!Hive.isBoxOpen(boxName)) {
        _logger.error('$boxName kapalı olduğu için yazma işlemi gerçekleştirilemedi');
        return;
      }

      final box = Hive.box<Map>(boxName);
      await box.delete(key);
      _logger.debug('$boxName içerisinden veri silindi: key="$key"');
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
      rethrow;
    }
  }

  /// Belirtilen kutudaki tüm verileri temizler.
  Future<void> clearBox({required String boxName}) async {
    try {
      if (!Hive.isBoxOpen(boxName)) {
        _logger.error('$boxName kapalı olduğu için yazma işlemi gerçekleştirilemedi');
        return;
      }

      final box = Hive.box<Map>(boxName);
      await box.clear();
      _logger.debug('$boxName içerisindeki verilerin hepsi silindi');
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
      rethrow;
    }
  }

  /// Belirtilen Hive kutusundaki tüm verileri key-value çiftleri olarak döner.
  ///
  /// [boxName]: Erişim yapılacak kutunun adı.
  /// Eğer kutu kapalıysa veya hata oluşursa boş bir map döner.
  Map<dynamic, dynamic> getAll({required String boxName}) {
    try {
      if (!Hive.isBoxOpen(boxName)) {
        _logger.error('$boxName kapalı olduğu için yazma işlemi gerçekleştirilemedi');
        throw Exception('$boxName kapalı olduğu için yazma işlemi gerçekleştirilemedi');
      }

      final box = Hive.box<Map>(boxName);
      final data = box.toMap();
      _logger.debug('$boxName içerisinden ${data.length} kayıt listelendi');
      return data;
    } catch (e, stackTrace) {
      _logger.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
      rethrow;
    }
  }
}
