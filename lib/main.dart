import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'package:valentines_garage/screens/login_screen.dart';
import 'package:valentines_garage/screens/valentine/valentine_page_navigation.dart';
import 'package:valentines_garage/utilities/app_theme.dart';

void main() {
  //only allow portrait orientation
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context, listen: true);

        return MaterialApp(
          title: 'Valentine\'s Garage',

          themeMode: themeProvider.themeMode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,

          debugShowCheckedModeBanner: false,
          home: const SafeArea(
              child: ValentinePageNavigation()
          ),
        );
      },
    );
  }
}