import 'package:flutter/material.dart';

/// App theme configuration
class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // Color constants
  static const Color primaryColor = Colors.green;
  static const Color accentColor = Colors.orange;
  static const Color textColor = Colors.white;
  static const Color darkBackgroundColor = Colors.black54;
  static const Color scaffoldBackgroundColor = Color(0xFF121212);

  static final ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: accentColor,
      surface: scaffoldBackgroundColor,
      background: scaffoldBackgroundColor,
    ),
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    useMaterial3: true,
    fontFamily: 'Roboto',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: accentColor,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
    ),
  );
}
