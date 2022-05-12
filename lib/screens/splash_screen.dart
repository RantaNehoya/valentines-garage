import 'package:flutter/material.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'package:valentines_garage/screens/start_screen.dart';

class AppSplashScreen extends StatelessWidget {
  const AppSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //animated splash screen
    return AnimatedSplashScreen(
      splash: 'assets/images/mechanic.png',
      nextScreen: const StartScreen(),
      splashTransition: SplashTransition.fadeTransition,
      splashIconSize: MediaQuery.of(context).size.width * 0.5,
      duration: 500,
    );
  }
}
