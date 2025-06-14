import 'package:com_nectrom_metetemplate/core/constants/routes_constants.dart';
import 'package:com_nectrom_metetemplate/core/managers/logger_manager.dart';
import 'package:com_nectrom_metetemplate/core/utils/app_utils.dart';
import 'package:com_nectrom_metetemplate/features/example/example_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static final Routes instance = Routes();

  Routes() {
    LoggerManager.instance.debug('Routes başlatıldı');
  }

  final GoRouter router = GoRouter(
    initialLocation: RoutesConstants.defaultScreen,
    navigatorKey: AppUtils.instance.navigatorKey,
    debugLogDiagnostics: true,
    // errorBuilder: (context, state) => const ErrorScreen(),
    routes: [
      _generateStandardGoRoute(RoutesConstants.defaultScreen, const ExampleScreen()),
      // _generateStandardGoRoute(RoutesConstants.defaultScreen, const SplashScreen()),
      // _generateStandardGoRoute(RoutesConstants.leaveScreen, const LeaveScreen()),
      // _generateStandardGoRoute(RoutesConstants.errorScreen, const ErrorScreen()),
      // _generateDataGoRoute(...), // örnek için buraya da eklenebilir
    ],
  );

  /// Tüm navigation stack'i temizleyerek verilen route'a gider.
  void clearStackAndNavigate(
    String? name, {
    Map<String, String>? pathParameters,
    Map<String, dynamic>? queryParameters,
    Object? extra,
  }) {
    final context = AppUtils.instance.navigatorKey.currentContext;
    if (context == null || name == null) return;

    final router = GoRouter.of(context);

    // Stack'i temizle
    while (router.canPop()) {
      router.pop();
    }

    // Yeni sayfaya geç
    router.pushReplacementNamed(
      name,
      pathParameters: pathParameters ?? {},
      queryParameters: queryParameters ?? {},
      extra: extra,
    );
  }

  /// Basit sayfalar için fade animasyonlu geçiş sağlar.
  static GoRoute _generateStandardGoRoute(String path, Widget screen) {
    return GoRoute(
      name: path,
      path: path,
      pageBuilder: (context, state) {
        return CustomTransitionPage<void>(
          key: state.pageKey,
          child: screen,
          transitionsBuilder: _fadeTransition,
        );
      },
    );
  }

  /// Veriye bağlı sayfalar için routing.
  static GoRoute _generateDataGoRoute<T>(
    String path,
    Widget Function(Map<String, dynamic>) screenBuilder,
  ) {
    return GoRoute(
      name: path,
      path: path,
      pageBuilder: (context, state) {
        final data = state.extra as Map<String, dynamic>? ?? {};
        return CustomTransitionPage<void>(
          key: state.pageKey,
          child: screenBuilder(data),
          transitionsBuilder: _fadeTransition,
        );
      },
    );
  }

  /// Ortak animasyon (fade)
  static Widget _fadeTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }
}
