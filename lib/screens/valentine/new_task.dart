import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:valentines_garage/screens/valentine/valentine_page_navigation.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:valentines_garage/utilities/data/task_data.dart';
import 'package:valentines_garage/utilities/data/task_view.dart';
import 'assign_employees.dart';

class newTask extends StatefulWidget {
  @override
  newTaskState createState() {
    return newTaskState();
  }
}

class newTaskState extends State<newTask> {
  final data = TaskData("", "", "", "", []);
  final titleController = TextEditingController();
  final descController = TextEditingController();

  assignPage aP = assignPage();

  final format = DateFormat.MMMEd();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        elevation: 0,
        title: const Text(
          "New Task",
          style: TextStyle(fontSize: 25),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  color: Theme.of(context).scaffoldBackgroundColor,),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.85,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),

                      Form(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                                  color: Colors.grey.withOpacity(0.2),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    assignEmployee();
                                  },
                                  child: Text(
                                    'Assign Employees',
                                    style: TextStyle(color: Color(0xfff96060)),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.02,
                              ),

                              TextFormField(
                                  controller: titleController,
                                  decoration: InputDecoration(
                                    hintText: "Title",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  onChanged: (_) {
                                    data.title = titleController.text;
                                  },
                                  style: const TextStyle(fontSize: 18)),

                              const SizedBox(
                                height: 30,
                              ),

                              Text(
                                "Description",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 150,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      topLeft: Radius.circular(15)),
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: descController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Add description here",
                                    ),
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                    onChanged: (_) {
                                      data.description = descController.text;
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.2),
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                    ),
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.5),
                                    )),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: IconButton(
                                        icon: Icon(Icons.attach_file,
                                            color: Colors.grey),
                                        onPressed: () {
                                          _pickFile();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  color: Colors.grey.withOpacity(0.2),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    DatePicker.showDatePicker(context,
                                        showTitleActions: true,
                                        minTime: DateTime(2018, 3, 5),
                                        maxTime: DateTime(2065, 6, 7),

                                        onChanged: (date) {
                                          print('change $date');
                                        },
                                        onConfirm: (date) {
                                          String setDate = format.format(date);
                                          data.date = setDate;
                                        },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.en
                                    );
                                  },
                                  child: Text(
                                    'Due Date',
                                    style: TextStyle(color: Color(0xfff96060)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    "Level of Priority",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                      height: 80,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                          color: Colors.green.withOpacity(0.3)),
                                      child: TextButton(
                                        child: Text('Low'),
                                        style: TextButton.styleFrom(
                                          primary: Colors.green,
                                          backgroundColor: Colors.transparent,
                                        ),
                                        onPressed: () {
                                          String prio = "Low";
                                          data.priority = prio;
                                        },
                                      )),
                                  Container(
                                      height: 80,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                          color: Colors.orange.withOpacity(0.3)),
                                      child: TextButton(
                                        child: Text('Medium'),
                                        style: TextButton.styleFrom(
                                          primary: Colors.orange,
                                          backgroundColor: Colors.transparent,
                                        ),
                                        onPressed: () {
                                          String prio = "Medium";
                                          data.priority = prio;
                                        },
                                      )),
                                  Container(
                                      height: 80,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                          color: Colors.red.withOpacity(0.3)),
                                      child: TextButton(
                                        child: Text('High'),
                                        style: TextButton.styleFrom(
                                          primary: Colors.red,
                                          backgroundColor: Colors.transparent,
                                        ),
                                        onPressed: () {
                                          String prio = "High";
                                          data.priority = prio;
                                        },
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 20,
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
                          child: Text('Add Task'),
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.transparent,
                          ),
                          onPressed: () {
                            titleController.clear();
                            descController.clear();

                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed(
                              '/secondPage',
                              arguments: {
                                'title': data.title,
                                'desc': data.description,
                                'date': data.date,
                                'priority': data.priority,
                                'assigned': data.assigned
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pickFile() async {
    // opens storage to pick files and the picked file or files
    // are assigned into result and if no file is chosen result is null.
    // you can also toggle "allowMultiple" true or false depending on your need
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    // if no file is picked
    if (result == null) return;

    // we get the file from result object
    final file = result.files.first;

    _openFile(file);
  }

  void _openFile(PlatformFile file) {
    OpenFile.open(file.path);
  }

  backHome() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ValentinePageNavigation()));
  }
  assignEmployee() {
    Navigator.push(
      context, MaterialPageRoute(builder: (context) => assignPage(),),
    );
  }
}
