import 'package:flutter/material.dart';

import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:valentines_garage/screens/employees/employee_tasks.dart';
import 'package:valentines_garage/screens/employees/settings.dart';
import 'package:valentines_garage/utilities/app_theme.dart';

class EmployeePageNavigation extends StatefulWidget {
  const EmployeePageNavigation({Key? key}) : super(key: key);

  @override
  State<EmployeePageNavigation> createState() => _EmployeePageNavigationState();
}

class _EmployeePageNavigationState extends State<EmployeePageNavigation> {

  //page navigation
  final List<Widget> _pages = const [
    EmployeeTasks(),
    Settings(),
  ];

  //handler to change active index
  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isLight = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.light ? Colors.white : Theme.of(context).primaryColorDark;

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: FancyBottomNavigation(
          barBackgroundColor: isLight,
          tabs: [
            TabData(iconData: FontAwesomeIcons.list, title: 'Tasks'),
            TabData(iconData: Icons.settings_outlined, title: 'Settings'),
          ],
          onTabChangedListener: (position) {
            setState(() {
              _activeIndex = position;
            });
          },
        ),

        //page bodies
        body: _pages.elementAt(_activeIndex),
      ),
    );
  }
}
