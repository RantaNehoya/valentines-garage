import 'new_task.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class homePage extends StatefulWidget {
  homePage({Key? key}) : super(key: key);
  static List task_list = [];

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {

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
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Work List",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                            style: TextStyle(fontSize: 18, color: Colors.grey)),

                        //todo
                        ...(List.generate(
                            homePage.task_list.length, (index){
                              return homePage.task_list[index];
                        })),
                      ],
                    ),
                  ),
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

  openNewTask() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => newTask()));
  }
}
