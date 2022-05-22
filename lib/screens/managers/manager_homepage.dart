import 'package:flutter/material.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../valentine/new_task.dart';

class ManagerHome extends StatefulWidget {
  const ManagerHome({Key? key}) : super(key: key);

  @override
  State<ManagerHome> createState() => _ManagerHomeState();
}

class _ManagerHomeState extends State<ManagerHome> {
  String filterType = "today";
  DateTime today = new DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
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
  //TODO
  // final List<Widget> tasks = [];
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
                  style: TextStyle(fontSize: 25),
                ),
                centerTitle: true,
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
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) {
                  // Use `selectedDayPredicate` to determine which day is currently selected.
                  // If this returns true, then `day` will be marked as selected.

                  // Using `isSameDay` is recommended to disregard
                  // the time-part of compared DateTime objects.
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    // Call `setState()` when updating the selected day
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  }
                },
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    // Call `setState()` when updating calendar format
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  // No need to call `setState()` here
                  _focusedDay = focusedDay;
                },
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
                          //todo
                          // taskWidget(Color(0xfff96060), "Repair Trailer", "9:00 am",),
                          // taskWidget(Colors.blue, "Wheel Alignment", "11:00 am",),
                          // taskWidget(Colors.green, "Engine Check", "3:00 pm",),
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
          onTap: () {
            openNewTask();
          },
        ),
        IconSlideAction(
          caption: "Delete",
          color: color,
          icon: Icons.delete,
          onTap: () {
            //remove
            setState(() {});
          },
        )
      ],
    );
  }

  openNewTask() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => newTask()));
  }
}
