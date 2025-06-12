import 'package:flutter/material.dart';

class ThemeConstants {
  static final ThemeConstants instance = ThemeConstants();

  // Tüm Renkler
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;
  static const Color transparentColor = Colors.transparent;
  static const Color primaryColor = Color(0xFFFF6600);
  static const Color onPrimaryColor = Colors.white;
  static const Color secondaryColor = Colors.blueAccent;
  static const Color onSecondaryColor = Colors.white;
  static const Color errorColor = Colors.red;
  static const Color onErrorColor = Colors.white;
  static const Color surfaceColor = Colors.white;
  static const Color onSurfaceColor = Colors.black;
  static const Color appBarBgColor = Color(0xffE6F4FE);

  // Metin Renkleri
  static const Color textColorLight = Colors.white;
  static const Color textColorDark = Color(0xFFE2E2E5);

  // Dark Tema Renkleri
  static const Color darkBackground = Color(0xFF1A1C1E);
  static const Color darkSurface = Color(0xFF1A1C1E);
  static const Color darkOnSurface = Color(0xFFE2E2E5);

  Map<String, ThemeData> systemThemeMap = {
    "light": ThemeData(
      primaryColor: primaryColor,
      hintColor: primaryColor,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: primaryColor,
        onPrimary: onPrimaryColor,
        secondary: secondaryColor,
        onSecondary: onSecondaryColor,
        error: errorColor,
        onError: onErrorColor,
        surface: surfaceColor,
        onSurface: onSurfaceColor,
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: whiteColor,
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: primaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: primaryColor,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
      cardTheme: const CardTheme(
        color: primaryColor,
      ),
      expansionTileTheme: const ExpansionTileThemeData(
        iconColor: whiteColor,
        collapsedIconColor: whiteColor,
        shape: RoundedRectangleBorder(
          side: BorderSide.none,
        ),
      ),
    ),
    "dark": ThemeData.dark().copyWith(
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFF8ACEFF),
        onPrimary: Color(0xFF00344E),
        primaryContainer: Color(0xFF004B6F),
        onPrimaryContainer: Color(0xFFC9E6FF),
        secondary: Color(0xFFB7C9D9),
        onSecondary: Color(0xFF22323F),
        secondaryContainer: Color(0xFF384956),
        onSecondaryContainer: Color(0xFFD3E5F5),
        tertiary: Color(0xFF87CEFF),
        onTertiary: Color(0xFF00344C),
        tertiaryContainer: Color(0xFF004C6D),
        onTertiaryContainer: Color(0xFFC8E6FF),
        error: Color(0xFFFFB4AB),
        errorContainer: Color(0xFF93000A),
        onError: Color(0xFF690005),
        onErrorContainer: Color(0xFFFFDAD6),
        surface: darkSurface,
        onSurface: darkOnSurface,
        onSurfaceVariant: Color(0xFFC1C7CE),
        outline: Color(0xFF8B9198),
        onInverseSurface: darkBackground,
        inverseSurface: darkOnSurface,
        inversePrimary: Color(0xFF006491),
        shadow: Color(0xFF000000),
        surfaceTint: Color(0xFF8ACEFF),
        outlineVariant: Color(0xFF41474D),
        scrim: Color(0xFF000000),
      ),
      appBarTheme: const AppBarTheme(actionsIconTheme: IconThemeData(color: Colors.white)),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 0.0,
        type: BottomNavigationBarType.fixed,
      ),
    ),
  };
}
