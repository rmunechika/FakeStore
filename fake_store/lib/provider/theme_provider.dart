import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme(bool isOn) {
    _themeMode = isOn ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme(
        primary: Colors.lightBlue,
        primaryContainer: Colors.lightBlue[700],
        secondary: Colors.lightBlueAccent,
        secondaryContainer: Colors.lightBlueAccent[700],
        tertiary: Colors.cyan.shade400,
        surface: Colors.white,
        surfaceContainer: Colors.white,
        error: Colors.red,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.black,
        onError: Colors.white,
        brightness: Brightness.light,
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
            fontSize: 48.0,
            fontWeight: FontWeight.bold,
            color: Colors.black), // headline large
        headlineMedium: TextStyle(
            fontSize: 36.0,
            fontWeight: FontWeight.bold,
            color: Colors.black), // headline medium
        headlineSmall: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.black), // headline small
        titleLarge:
            TextStyle(fontSize: 20.0, color: Colors.black), // title large
        titleMedium:
            TextStyle(fontSize: 18.0, color: Colors.black), // title medium
        titleSmall:
            TextStyle(fontSize: 16.0, color: Colors.black), // title small
        bodyLarge: TextStyle(fontSize: 16.0, color: Colors.black), // body large
        bodyMedium:
            TextStyle(fontSize: 14.0, color: Colors.black), // body medium
        bodySmall: TextStyle(fontSize: 12.0, color: Colors.black),
        labelMedium: TextStyle(fontSize: 12.0, color: Colors.white),
        labelSmall:
            TextStyle(fontSize: 10.0, color: Colors.white), // body small
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      iconTheme: IconThemeData(color: Colors.black, size: 30),
    );
  }

  ThemeData get darkTheme {
    return ThemeData(
      colorScheme: ColorScheme(
        primary: Colors.blue.shade600,
        primaryContainer: Colors.blue[700],
        secondary: Colors.blueAccent,
        secondaryContainer: Colors.blueAccent[700],
        tertiary: Colors.cyan.shade700,
        surface: Colors.black,
        surfaceContainer: Colors.black,
        error: Colors.red,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: Colors.white,
        onError: Colors.black,
        brightness: Brightness.dark,
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
            fontSize: 48.0,
            fontWeight: FontWeight.bold,
            color: Colors.white), // headline large
        headlineMedium: TextStyle(
            fontSize: 36.0,
            fontWeight: FontWeight.bold,
            color: Colors.white), // headline medium
        headlineSmall: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white), // headline small
        titleLarge:
            TextStyle(fontSize: 20.0, color: Colors.white), // title large
        titleMedium:
            TextStyle(fontSize: 18.0, color: Colors.white), // title medium
        titleSmall:
            TextStyle(fontSize: 16.0, color: Colors.white), // title small
        bodyLarge: TextStyle(fontSize: 16.0, color: Colors.white), // body large
        bodyMedium:
            TextStyle(fontSize: 14.0, color: Colors.white), // body medium
        bodySmall: TextStyle(fontSize: 12.0, color: Colors.white),
        labelMedium: TextStyle(fontSize: 12.0, color: Colors.black),
        labelSmall:
            TextStyle(fontSize: 10.0, color: Colors.black), // body small
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        titleTextStyle: const TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      iconTheme: IconThemeData(color: Colors.white, size: 30),
    );
  }
}
