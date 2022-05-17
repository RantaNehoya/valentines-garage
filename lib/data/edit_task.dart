import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:valentines_garage/screens/valentine/valentine_page_navigation.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:valentines_garage/screens/employees/member_list.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import '../../utilities/department_list.dart';
import 'package:valentines_garage/screens/data/task_data.dart';
import 'package:valentines_garage/screens/data/task_view.dart';

class editTask extends StatefulWidget {
  @override
  editTaskState createState() {
    return new editTaskState();
  }
}

class editTaskState extends State<editTask> {
  //at index of TaskData
  final data = TaskData("", "", "", "");
  //at index of taskData
  final titleController = TextEditingController();
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFF44336),
        elevation: 0,
        title: Text(
          "New Task",
          style: TextStyle(fontSize: 25),
        ),
        leading: IconButton(
          onPressed: () {
            backHome();
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    color: Colors.white),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.85,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: TextField(
                            controller: titleController,
                            decoration: InputDecoration(
                              hintText: "Title",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onSubmitted: (title) {
                              setState(() {
                                data.title = title;
                              });
                            },
                            style: TextStyle(fontSize: 18)),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 180, left: 10, right: 10),
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                            child: TextField(
                              controller: descController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Add description here",
                              ),
                              style: TextStyle(
                                fontSize: 18,
                              ),
                              onSubmitted: (description) {
                                setState(() {
                                  data.description = description;
                                });
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
                              }, onConfirm: (date) {
                                String setDate = "$date";
                                setState(() {
                                  data.date = setDate;
                                });
                              },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.en);
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
                        Text(
                          "Add Member",
                          style: TextStyle(fontSize: 18),
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
                          // child: Text(
                          //   "Members",
                          //   style: TextStyle(
                          //     fontSize: 18,
                          //   ),
                          // ),
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
                                  onPressed: () {},
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
                                  onPressed: () {},
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
                                  onPressed: () {},
                                )),
                          ],
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
                            color: Color(0xFFF44336),
                          ),
                          child: TextButton(
                            child: Text('Update Task'),
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.transparent,
                            ),
                            onPressed: () {
                              //update TaskData at that index

                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => homePage(
                              //       data: data,
                              //     ),
                              //   ),
                              // );
                              ;
                            },
                          ),
                        )
                      ]),
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
}
