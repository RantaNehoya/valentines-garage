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
        backgroundColor: Color(0xfff96060),
        title: Text("Task View"),
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 54.0,
              padding: EdgeInsets.all(12.0),
            ),
            Text(
              "Title: ${data.title}",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            Text("Description: ${data.description}",
                style: TextStyle(fontSize: 20)),
            SizedBox(
              height: 15,
            ),
            Text("Department: ${data.department}",
                style: TextStyle(fontSize: 20)),
            SizedBox(
              height: 15,
            ),
            Text("Date: ${data.date}",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.italic)),
            SizedBox(
              height: 15,
            ),
            Text("Members: ${data.added_members}",
                style: TextStyle(fontSize: 20)),
            SizedBox(
              height: 15,
            ),
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
                      data.department, '${data.date}', data.added_members));
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
