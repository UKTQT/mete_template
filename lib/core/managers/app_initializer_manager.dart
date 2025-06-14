import 'package:com_nectrom_metetemplate/core/managers/logger_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class AppInitializerManager {
  static final AppInitializerManager instance = AppInitializerManager();

  LoggerManager? _logger;

  AppInitializerManager() {}

  /// Uygulamanın başlatılması için gerekli olan tüm işlemleri gerçekleştirir.
  Future<void> initialize() async {
    await _initEnv(); // Ortam değişkenlerini yükler.
    await _initLocalization(); // Dil ayarlarını yapılandırır.
    await _initDatabase(); // Veritabanını başlatır.
    await _configureSystemUI(); // Sistem arayüzünü düzenler.
    _initCrashlyticsOrBugTracking(); // Hata yönetimini yapılandırır.

    _logger = LoggerManager.instance;

    _logger!.debug('AppInitializerManager başlatıldı');
  }

  /// `.env` dosyasını yükleyerek ortam değişkenlerini erişilebilir hale getirir.
  Future<void> _initEnv() async {
    await dotenv.load(fileName: ".env");
  }

  /// Uygulamanın yerelleştirme sistemini başlatır.
  Future<void> _initLocalization() async {
    await EasyLocalization.ensureInitialized();
  }

  /// Hive veritabanını başlatır ve uygulama belgeleri dizininde saklar.
  Future<void> _initDatabase() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
  }

  /// Uygulamada hata izleme ve hata bildirme sistemini başlatır.
  void _initCrashlyticsOrBugTracking() {
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      _logger!.error('🔴 Hata: ${details.exceptionAsString()}');
    };
  }

  /// Bloc sağlayıcılarını yöneten liste.
  List<BlocProvider> get blocProviders => [
        /*   BlocProvider<NetworkManagerCubit>(
          create: (context) => NetworkManagerCubit(context: context),
          lazy: false,
        ), */
      ];

  /// Cihazın sistem arayüzünü (status bar, navigation bar vb.) özelleştirir.
  Future<void> _configureSystemUI() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp, // Sadece dikey yönlendirmeyi destekler.
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Durum çubuğunu şeffaf yapar.
        statusBarIconBrightness: Brightness.dark, // Durum çubuğu ikon rengini ayarlar.
        systemNavigationBarColor: Colors.white, // Alt navigasyon bar rengini belirler.
        systemNavigationBarIconBrightness: Brightness.dark, // Alt bar ikon rengini belirler.
      ),
    );
  }
}
