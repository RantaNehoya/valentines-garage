import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:valentines_garage/screens/valentine/valentine_homepage.dart';
import 'package:valentines_garage/utilities/data/task_data.dart';

import '../../widgets/checklist.dart';
import 'package:valentines_garage/screens/valentine/valentine_page_navigation.dart';

class SecondPage extends StatelessWidget {
  SecondPage({Key? key}) : super(key: key);

  List t = [];

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
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
              "Title: ${routeArgs['title']}",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            Text("Description: ${routeArgs['desc']}",
                style: TextStyle(fontSize: 20)),
            SizedBox(
              height: 15,
            ),
            // Text("Department: ${data.department}",
            //     style: TextStyle(fontSize: 20)),
            SizedBox(
              height: 15,
            ),
            Text("Date: ${routeArgs['date']}",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.italic)),
            SizedBox(
              height: 15,
            ),
            Text("Members: ${routeArgs['assigned']}",
              style: TextStyle(fontSize: 20),
            ),
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
                color: Theme.of(context).primaryColorDark,
              ),
              child: TextButton(
                child: Text('SAVE'),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.transparent,
                ),
                onPressed: () {
                  //add to tasklist
                  // tasklist.add(TaskData('${data.title}', '${data.description}',
                  //     data.department, '${data.date}', data.added_members));
                  homePage.task_list.add(
                    Checklist(
                      title: routeArgs['title'],
                      date: routeArgs['date'],
                      description: routeArgs['desc'],
                      priority: routeArgs['priority'],
                      assigned: routeArgs['assigned'],
                    ),
                  );

                  t.add({
                    'title': routeArgs['title'],
                    'date': routeArgs['date'],
                    'description': routeArgs['desc'],
                    'priority': routeArgs['priority'],
                    'assigned': routeArgs['assigned'],
                  });

                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
