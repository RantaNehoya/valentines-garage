// import 'package:flutter/material.dart';
//
// class Valentine extends StatefulWidget {
//   const Valentine({Key? key}) : super(key: key);
//
//   @override
//   State<Valentine> createState() => _ValentineState();
// }
//
// class _ValentineState extends State<Valentine> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).primaryColorDark,
//         title: const Text('Tasks'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//
//           children: [
//             Text('Valentine Page'),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'avenir'),
      home: homePage(),
    );
  }
}

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  String filterType = "today";
  DateTime today = new DateTime.now();
  String taskPop = "close";
  var monthNames = [
    "JAN",
    "FEB",
    "MAR",
    "APR",
    "MAY",
    "JUN",
    "JUL",
    "AUG",
    "SEPT",
    "OCT",
    "NOV",
    "DEC"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                backgroundColor: Theme.of(context).primaryColorDark,
                elevation: 0,
                title: Text(
                  "Work List",
                  style: TextStyle(fontSize: 30),
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.short_text,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {},
                  )
                ],
              ),
              Container(
                height: 70,
                color: Theme.of(context).primaryColorDark,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                changeFilter("today");
                              },
                              child: Text(
                                "Today",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 4,
                              width: 120,
                              color: (filterType == "today")
                                  ? Colors.white
                                  : Colors.transparent,
                            ),
                          ]),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                changeFilter("monthly");
                              },
                              child: Text(
                                "Monthly",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 4,
                              width: 120,
                              color: (filterType == "monthly")
                                  ? Colors.white
                                  : Colors.transparent,
                            ),
                          ]),
                    ]),
              ),
              (filterType == "monthly")
                  ? TableCalendar(
                      focusedDay: DateTime.now(),
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                    )
                  : Container(),
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Today ${monthNames[today.month - 1]}, ${today.day}/${today.year}",
                            style: TextStyle(fontSize: 18, color: Colors.grey))
                      ],
                    ),
                  ),
                  taskWidget(Color(0xfff96060), "Repair Trailer", "9:00 am"),
                  taskWidget(Colors.blue, "Wheel Alignment", "11:00 am"),
                  taskWidget(Colors.green, "Engine Check", "3:00 pm"),
                ],
              ))),
            ],
          )
        ],
      ),
    );
  }

  changeFilter(String filter) {
    filterType = filter;
    setState(() {});
  }

  Slidable taskWidget(Color color, String title, String time) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.3,
      child: Container(
          height: 80,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
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
                    border: Border.all(color: color, width: 4)),
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
                    time,
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
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
          onTap: () {},
        ),
        IconSlideAction(
          caption: "Delete",
          color: color,
          icon: Icons.edit,
          onTap: () {},
        )
      ],
    );
  }
}
