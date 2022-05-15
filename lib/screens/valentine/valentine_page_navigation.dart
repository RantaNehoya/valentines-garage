import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:valentines_garage/screens/valentine/valentine_homepage.dart';
import 'package:valentines_garage/screens/valentine/valentine_profile.dart';
import 'checklist.dart';
import 'newtask.dart';

class ValentinePageNavigation extends StatefulWidget {
  const ValentinePageNavigation({Key? key}) : super(key: key);

  @override
  State<ValentinePageNavigation> createState() =>
      _ValentinePageNavigationState();
}

class _ValentinePageNavigationState extends State<ValentinePageNavigation> {
  //page navigation
  final List<Widget> _pages = const [
    homePage(),
    ValentineProfile(),
  ];

  //handler to change active index
  int _activeIndex = 0;

  void _onTap(int index) {
    setState(() {
      _activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColorLight,
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          //todo: add tasks
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Wrap(
                  children: [
                    ListTile(
                      onTap: openNewTask,
                      leading: Icon(Icons.add_task),
                      title: Text('Add Task'),
                    ),
                    ListTile(
                      onTap: openNewChecklist,
                      leading: Icon(Icons.assignment_turned_in_outlined),
                      title: Text('Add Checklist'),
                    ),
                  ],
                );
              });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        height: MediaQuery.of(context).size.height * 0.08,
        icons: const [
          FontAwesomeIcons.list,
          Icons.person_outlined,
        ],
        activeIndex: _activeIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: _onTap,
      ),

      //page bodies
      body: _pages.elementAt(_activeIndex),
    );
  }

  openNewTask() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => NewTask()));
  }

  openNewChecklist() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CheckList()));
  }
}
