import 'package:flutter/material.dart';

import 'new_task.dart';

class AssignEmployee extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assign Employees',
      debugShowCheckedModeBanner: false,
    );
  }
}

class assignPage extends StatefulWidget {
  assignPage({required Key key, required this.title}) : super(key: key);

  final String title;

  @override
  _assignPageState createState() => _assignPageState();
}

class _assignPageState extends State<assignPage> {
  List data = [
    'Bang Chan',
    'Lee Know',
    'Changbin',
    'Hyunjin',
    'Han',
    'Felix',
    'Seungmin',
    'I.N.'
  ];
  List selectedItemsList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColorDark,
          title: Text(widget.title)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              'Selected Employees:',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Wrap(children: [
              for (var item = 0; item < selectedItemsList.length; item++)
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
                            Icons.account_circle,
                            color: Theme.of(context).accentColor,
                            size: 20,
                          )),
                      SizedBox(width: 4),
                      Text(selectedItemsList[item].toString()),
                      SizedBox(width: 4),
                      InkWell(
                          child: Icon(
                            Icons.close,
                            size: 18,
                            color: Theme.of(context).accentColor,
                          ),
                          onTap: () {
                            setState(() {
                              selectedItemsList.remove(selectedItemsList[item]);
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
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () => selectTappedItem(index),
                    title: Text('${data[index]}',
                        style: Theme.of(context).textTheme.bodyText1),
                    leading: Container(
                      padding: EdgeInsets.all(8),
                      decoration: selectedItemsList.contains(data[index])
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
                      child: !selectedItemsList.contains(data[index])
                          ? Icon(Icons.account_circle_outlined)
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
              color: Theme.of(context).primaryColor,
            ),
            child: TextButton(
              child: Text('Add Employees'),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.transparent,
              ),
              onPressed: () {
                openNewTask();
              },
            ),
          ),
        ],
      ),
    );
  }

  void selectTappedItem(int index) {
    if (selectedItemsList.contains(data[index])) {
      setState(() {
        selectedItemsList.remove(data[index]);
      });
      print(selectedItemsList);
    } else {
      setState(() {
        selectedItemsList.add(data[index]);
      });
      print(selectedItemsList);
    }
  }

  openNewTask() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => newTask()));
  }
}
