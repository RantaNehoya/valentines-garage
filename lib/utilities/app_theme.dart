import 'package:flutter/material.dart';

class AppTheme{
  static final darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(),
    primaryColor: const Color(0xFFA13333),
    primaryColorLight: const Color(0xFFA13333),
    primaryColorDark: const Color(0xFF461111),
    scaffoldBackgroundColor: const Color(0xFF040303),
    buttonTheme: const ButtonThemeData(
      colorScheme: ColorScheme.light(),
      buttonColor: Color(0xFFB3541E),
    ),

    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  );

  static final lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(),
    primaryColor: const Color(0xFFFFBC80),
    primaryColorLight: const Color(0xFFFFBC80),
    primaryColorDark: const Color(0xFFF76E11),

    scaffoldBackgroundColor: Colors.white,
    buttonTheme: const ButtonThemeData(
      colorScheme: ColorScheme.light(),
      buttonColor: Color(0xFFFF9F45),
    ),
    // navigationBarTheme: ,

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