import 'package:flutter/material.dart';

class AppTheme {
  // Shared colors
  static const Color accentColor = Color(0xFF80DEEA);

  // Light theme
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: const Color(0xFFFFFFFF),
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    textTheme: _textTheme(Brightness.light),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: Colors.black87,
    ),
    iconTheme: const IconThemeData(color: Colors.black54),
  );

  // Dark theme
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF0F1419),
    scaffoldBackgroundColor: const Color(0xFF0F1419),
    textTheme: _textTheme(Brightness.dark),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: Colors.white,
    ),
    iconTheme: const IconThemeData(color: Colors.white70),
  );

  static TextTheme _textTheme(Brightness brightness) {
    final color = brightness == Brightness.dark ? Colors.white : Colors.black87;
    return TextTheme(
      displayLarge: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 32, color: color),
      displayMedium: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 28, color: color),
      headlineSmall: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 20, color: color),
      titleMedium: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 16, color: color),
      bodyLarge: TextStyle(fontFamily: 'Poppins', fontSize: 16, color: color),
      bodyMedium: TextStyle(fontFamily: 'Poppins', fontSize: 14, color: color.withOpacity(0.8)),
    );
  }
}
