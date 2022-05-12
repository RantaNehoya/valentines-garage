import 'package:flutter/material.dart';

class Valentine extends StatefulWidget {
  const Valentine({Key? key}) : super(key: key);

  @override
  State<Valentine> createState() => _ValentineState();
}

class _ValentineState extends State<Valentine> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text('Valentine Page'),
          ],
        ),
      ),
    );
  }
}
