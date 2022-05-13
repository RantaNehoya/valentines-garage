import 'package:flutter/material.dart';

import 'package:avatar_glow/avatar_glow.dart';

import 'package:valentines_garage/widgets/change_theme_button.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[

          Stack(
            alignment: Alignment.center,
            children: <Widget>[

              //profile background
              Container(
                color: Theme.of(context).primaryColorDark,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.25,
              ),

              //profile avatar
              Padding(
                padding: const EdgeInsets.only(
                  top: 5.0,
                  bottom: 40.0,
                ),

                child: AvatarGlow(
                  glowColor: Theme.of(context).primaryColor,
                  endRadius: 70.0,

                  child: CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    radius: 50.0,

                    //todo: shared preferences
                    foregroundImage: const AssetImage('assets/images/unknown.png'),
                  ),
                ),
              ),

              const Positioned(
                bottom: 10.0,
                child: Text('John Doe',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const <Widget>[
                Text('Change Theme',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),

                ChangeThemeButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
