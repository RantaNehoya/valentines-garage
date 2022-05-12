import 'package:flutter/material.dart';

import 'package:valentines_garage/screens/login_screen.dart';
import 'package:valentines_garage/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static bool darkModeEnabled = false;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Valentine\'s Garage',

      theme: ThemeData.light().copyWith(
        primaryColor: Colors.red,

        //secondary colour
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.redAccent,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.red.shade700,
        scaffoldBackgroundColor: const Color(0xFF15202B),
      ),
      themeMode: MyApp.darkModeEnabled ? ThemeMode.dark : ThemeMode.light,

      debugShowCheckedModeBanner: false,
      home: const SafeArea(
          child: LoginScreen()
      ),
    );
  }
}