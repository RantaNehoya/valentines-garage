import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:valentines_garage/screens/valentine/valentine_homepage.dart';

import '../screens/valentine/new_task.dart';

class Checklist extends StatelessWidget {
  Checklist(
      {Key? key, Color? color, required this.title, required this.description, required this.date, required this.priority, required List this.assigned});
  Color? color;
  String title;
  String description;
  String date;
  String priority;
  List assigned;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.3,
      child: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.height * 0.7,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark.withOpacity(0.1),
              boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.03),
                offset: Offset(0, 9),
                blurRadius: 20,
                spreadRadius: 1)
          ]),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Colors.black,
                        width: 4)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  Text(
                    description,
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '$date - $priority',
                    style: TextStyle(fontSize: 18),
                  ),
                  // Text(
                  //   assigned.toString(),
                  //   style: TextStyle(fontSize: 18),
                  // ),
                ],
              ),
              Expanded(
                child: Container(),
              ),
              Container(
                height: 50,
                width: 5,
                color: color,
              ),
            ],
          )),
      secondaryActions: [
        IconSlideAction(
          caption: "Edit",
          color: Colors.white,
          icon: Icons.edit,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => newTask()));
          },
        ),
        IconSlideAction(
          caption: "Mark as Done",
          color: color,
          icon: Icons.done_outlined,
          onTap: () {
            //remove
            List.generate(
                homePage.task_list.length, (index) {
              homePage.task_list.removeAt(index);
            });
          },
        )
      ],
    );
  }
}
