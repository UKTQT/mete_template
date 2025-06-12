import 'package:com_nectrom_metetemplate/core/constants/theme_constants.dart';
import 'package:com_nectrom_metetemplate/core/managers/app_initializer_manager.dart';
import 'package:com_nectrom_metetemplate/core/managers/environment_manager.dart';
import 'package:com_nectrom_metetemplate/core/managers/localization_manager.dart';
import 'package:com_nectrom_metetemplate/core/managers/logger_manager.dart';
import 'package:com_nectrom_metetemplate/core/utils/app_utils.dart';
import 'package:com_nectrom_metetemplate/routing/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    LoggerManager.instance.debug('Uygulama ayağa kaldırılıyor');

    /// Uygulamanın başlatılması için gerekli olan tüm işlemleri gerçekleştirir.
    await AppInitializerManager.instance.initialize();

    runApp(const AppEntryPoint());
  } catch (e, stackTrace) {
    LoggerManager.instance.error('🔴 Hata: ${e.toString()}\nStackTrace: $stackTrace');
    rethrow;
  }
}

class AppEntryPoint extends StatelessWidget {
  const AppEntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppInitializerManager.instance.blocProviders,
      child: EasyLocalization(
        supportedLocales: LocalizationManager.instance.supportedLocales,
        path: LocalizationManager.instance.localePath,
        fallbackLocale: LocalizationManager.instance.fallbackLocale,
        useOnlyLangCode: true,
        useFallbackTranslations: true,
        useFallbackTranslationsForEmptyResources: true,
        ignorePluralRules: true,
        saveLocale: true,
        child: const MainApp(),
      ),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    LoggerManager.instance.error('MaterialApp çiziliyor...');

    return MaterialApp.router(
      title: EnvironmentManager.appName,
      debugShowCheckedModeBanner: EnvironmentManager.debugShowCheckedBanner,
      themeMode: ThemeMode.system,
      theme: ThemeConstants.instance.systemThemeMap["light"],
      darkTheme: ThemeConstants.instance.systemThemeMap["dark"],
      scaffoldMessengerKey: AppUtils.instance.scaffoldMessengerKey,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      routeInformationParser: Routes.instance.router.routeInformationParser,
      routerDelegate: Routes.instance.router.routerDelegate,
      routeInformationProvider: Routes.instance.router.routeInformationProvider,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: const TextScaler.linear(1.0),
        ),
        child: child!,
      ),
    );
  }
}
