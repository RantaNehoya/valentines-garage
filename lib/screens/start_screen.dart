import 'package:flutter/material.dart';

import 'package:valentines_garage/widgets/constants.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            //logo image
            Image(
              image: const AssetImage(
                'assets/images/mechanic.png',
              ),
              height: MediaQuery.of(context).size.height * 0.5,
            ),

            //start buttons
            kStartScreenButton(
              ctx: context,
              user: 'Valentine',
              ftn: (){
                //todo: valentine sign in page
              },
            ),

            kStartScreenButton(
              ctx: context,
              user: 'Senior Staff',
              ftn: (){
                //todo: valentine sign in page
              },
            ),

            kStartScreenButton(
              ctx: context,
              user: 'Employee',
              ftn: (){
                //todo: valentine sign in page
              },
            ),
          ],
        ),
      ),
    );
  }
}
