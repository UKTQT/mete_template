import 'package:flutter/material.dart';

class AppUtils {
  static final AppUtils instance = AppUtils();

  /// Global erişim için navigator ve snackbar key'leri
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  /// Uygulamanın bağlamına erişim
  BuildContext? get context => navigatorKey.currentContext;

  /// Ekran boyutu, oran ve yön bilgileri
  Size get screenSize => MediaQuery.of(context!).size;
  double get screenHeight => screenSize.height;
  double get screenWidth => screenSize.width;
  double get devicePixelRatio => MediaQuery.of(context!).devicePixelRatio;
  Orientation get orientation => MediaQuery.of(context!).orientation;

  /// Tema bilgileri
  ThemeData get theme => Theme.of(context!);
  Brightness get brightness => MediaQuery.of(context!).platformBrightness;
  bool get isDarkMode => brightness == Brightness.dark;

  /// Varsayılan kenar yuvarlama değeri
  double get defaultRadius => 8.0;

  /// Ekrana göre oranlı yükseklik-genişlik
  double heightRatio(double factor) => screenHeight * factor;
  double widthRatio(double factor) => screenWidth * factor;

  /// Responsive yazı boyutu (1400px referanslı)
  double textScaleFactor(BuildContext context, {double maxScale = 2.0}) {
    final width = MediaQuery.of(context).size.width;
    final scale = (width / 1400) * maxScale;
    return scale.clamp(1.0, maxScale);
  }

  /// İlk harfleri büyük hale çevirme
  String capitalizeWords(String? input) {
    if (input == null || input.isEmpty) return '';
    return input.toLowerCase().split(' ').map((word) => word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '').join(' ');
  }

  /// Resim verisini Image widget'a çevirme
  Widget? parseImage({
    required String? imagePath,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    if (imagePath == null || imagePath.isEmpty) return null;

    if (imagePath.startsWith('data:image')) {
      try {
        final imageData = Uri.parse(imagePath).data?.contentAsBytes();
        return imageData != null ? Image.memory(imageData, width: width, height: height, fit: fit) : null;
      } catch (_) {
        return null;
      }
    } else if (imagePath.startsWith('http')) {
      return Image.network(imagePath, width: width, height: height, fit: fit);
    } else if (imagePath.startsWith('assets')) {
      return Image.asset(imagePath, width: width, height: height, fit: fit);
    }
    return null;
  }
}
