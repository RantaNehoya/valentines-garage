import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:day_night_switcher/day_night_switcher.dart';

import 'package:valentines_garage/utilities/app_theme.dart';

class ChangeThemeButton extends StatefulWidget {
  const ChangeThemeButton({Key? key}) : super(key: key);

  @override
  State<ChangeThemeButton> createState() => _ChangeThemeButtonState();
}

class _ChangeThemeButtonState extends State<ChangeThemeButton> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return DayNightSwitcher(
      isDarkModeEnabled: themeProvider.isDarkMode,
      onStateChanged: (value) {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(value);
      },
    );
  }
}
