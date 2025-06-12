import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});
}

abstract class BaseScreenState<T extends BaseScreen> extends State<T> with WidgetsBindingObserver {
  List<DeviceOrientation> _screenOrientation = const [
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _setPreferredScreenOrientation();
  }

  void _setPreferredScreenOrientation() {
    SystemChrome.setPreferredOrientations(_screenOrientation);
  }

  /// Ekran yönünü güncelleme
  void updateScreenOrientation(List<DeviceOrientation> orientations) {
    if (mounted) {
      setState(() {
        _screenOrientation = orientations;
      });
      _setPreferredScreenOrientation();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    debugPrint('App Lifecycle State Changed: $state');
  }

  @override
  void didChangeLocales(List<Locale>? locale) {
    debugPrint('Locale changed: $locale');
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    debugPrint('Screen metrics changed');
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    debugPrint('Platform brightness changed');
  }
}
