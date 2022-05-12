import 'package:flutter/material.dart';

import 'package:valentines_garage/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Valentine\'s Garage',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const AppSplashScreen(),
    );
  }
}