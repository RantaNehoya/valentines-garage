import 'package:flutter/material.dart';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:day_night_switcher/day_night_switcher.dart';

import 'package:valentines_garage/main.dart';

class ValentineProfile extends StatefulWidget {
  const ValentineProfile({Key? key}) : super(key: key);

  @override
  State<ValentineProfile> createState() => _ValentineProfileState();
}

class _ValentineProfileState extends State<ValentineProfile> {

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
                color: Colors.orange,
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
                child: Text('Valentine',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          GestureDetector(
            child: const Padding(
              padding: EdgeInsets.only(
                top: 20.0,
                bottom: 8.0,
              ),
              child: Text('Manage Staff',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            onTap: (){
              //todo: manage staff
            },
          ),

          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 8.0,
            ),
            child: Divider(
              thickness: 1.0,
            ),
          ),

          //todo: change theme
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Text('Change Theme',
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),

              DayNightSwitcher(
                isDarkModeEnabled: MyApp.darkModeEnabled,
                onStateChanged: (_) {
                  setState(() {
                    MyApp.darkModeEnabled = MyApp.darkModeEnabled ? false : true;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
