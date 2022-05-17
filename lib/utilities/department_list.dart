import 'package:flutter/material.dart';
import '../screens/data/task_view.dart';
import '../screens/valentine/newtask.dart';
import 'package:valentines_garage/screens/data/task_data.dart';

class DepartmentApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Select Members',
      debugShowCheckedModeBanner: false,
      home: Department(),
    );
  }
}

class Department extends StatefulWidget {
  const Department({Key? key}) : super(key: key);

  @override
  _DepartmentState createState() => _DepartmentState();
}

class _DepartmentState extends State<Department> {
  final data = TaskData("", "", [], "", []);
  List dep = [
    'Electrical',
    'Mechanical',
    'Trailer',
  ];
  List selectedItemsList_Dep = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFFF44336), title: Text("Department Page")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              'Selected Department:',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Wrap(children: [
              for (var item = 0; item < selectedItemsList_Dep.length; item++)
                Container(
                  margin: EdgeInsets.only(right: 8, top: 8),
                  padding: EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Theme.of(context).accentColor.withOpacity(0.3)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.3)),
                          child: Icon(
                            Icons.business_center_outlined,
                            color: Theme.of(context).accentColor,
                            size: 20,
                          )),
                      SizedBox(width: 4),
                      Text(selectedItemsList_Dep[item].toString()),
                      SizedBox(width: 4),
                      InkWell(
                          child: Icon(
                            Icons.close,
                            size: 18,
                            color: Theme.of(context).accentColor,
                          ),
                          onTap: () {
                            setState(() {
                              selectedItemsList_Dep
                                  .remove(selectedItemsList_Dep[item]);
                            });
                          })
                    ],
                  ),
                ),
            ]),
          ),
          Divider(
              color: Theme.of(context).accentColor.withOpacity(0.6),
              endIndent: 16,
              thickness: 1,
              indent: 16),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
                itemCount: dep.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () => selectTappedItem_Dep(index),
                    title: Text('${dep[index]}',
                        style: Theme.of(context).textTheme.bodyText1),
                    leading: Container(
                      padding: EdgeInsets.all(8),
                      decoration: selectedItemsList_Dep.contains(dep[index])
                          ? BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.8))
                          : BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.3)),
                      child: !selectedItemsList_Dep.contains(dep[index])
                          ? Icon(Icons.business_center)
                          : Icon(Icons.check, color: Colors.white),
                    ),
                  );
                }),
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
              child: Text('Add Department'),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.transparent,
              ),
              onPressed: () {
                data.department = List.from(selectedItemsList_Dep);

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => newTask()));
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => SecondPage(
                //               data: data,
                //             )));
              },
            ),
          )
        ],
      ),
    );
  }

  void selectTappedItem_Dep(int index) {
    if (selectedItemsList_Dep.contains(dep[index])) {
      setState(() {
        selectedItemsList_Dep.remove(dep[index]);
      });
      print(selectedItemsList_Dep);
    } else {
      setState(() {
        selectedItemsList_Dep.add(dep[index]);
      });
      print(selectedItemsList_Dep);
    }
  }
}

// data.department = List.from(selectedItemsList_Dep);
