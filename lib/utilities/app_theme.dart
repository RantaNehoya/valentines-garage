import 'package:flutter/material.dart';

class AppTheme{
  static final darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(),
    primaryColor: Colors.orange,
    primaryColorLight: const Color(0xFF867365),
    primaryColorDark: const Color(0xFF8F7034),
    scaffoldBackgroundColor: const Color(0xFF15202B),

    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  );

  static final lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(),
    primaryColor: Colors.red.shade900,
    primaryColorLight: const Color(0xFFFF7961),
    primaryColorDark: const Color(0xFFF44336),
    scaffoldBackgroundColor: Colors.white,

    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
  );
}

class ThemeProvider extends ChangeNotifier{
  ThemeMode themeMode = ThemeMode.light;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isDark){
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}