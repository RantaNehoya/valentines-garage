import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:valentines_garage/screens/valentine/valentine_homepage.dart';
import 'package:valentines_garage/screens/data/task_data.dart';

class SecondPage extends StatelessWidget {
  final TaskData data;

  SecondPage({required this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Task View"),
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Container(
              height: 54.0,
              padding: EdgeInsets.all(12.0),
            ),
            Text("Title: ${data.title}"),
            Text("Description: ${data.description}"),
            Text("Date: ${data.date}"),
            Text("Priority Level: ${data.priority}"),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                color: Color(0xFFF44336),
              ),
              child: TextButton(
                child: Text('SAVE'),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.transparent,
                ),
                onPressed: () {
                  //add to tasklist
                  tasklist.add(TaskData('${data.title}', '${data.description}',
                      '${data.date}', '${data.priority}'));
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => homePage()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
