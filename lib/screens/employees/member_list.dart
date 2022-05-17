import 'package:flutter/material.dart';
import 'package:valentines_garage/screens/data/task_data.dart';
import '../data/task_view.dart';
import '../valentine/newtask.dart';

class MemberApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Select Members',
      debugShowCheckedModeBanner: false,
      home: Members(),
    );
  }
}

class Members extends StatefulWidget {
  const Members({Key? key}) : super(key: key);

  @override
  _MembersState createState() => _MembersState();
}

class _MembersState extends State<Members> {
  final data = TaskData("", "", [], "", []);
  List members = [
    'Christopher',
    'Felix',
    'Changbin',
    'Lee Know',
    'Hyunjin',
    'Han',
    'Seungmin',
    'I.N'
  ];
  List selectedItemsList_Members = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFFF44336), title: Text("Member Page")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
              for (var item = 0;
                  item < selectedItemsList_Members.length;
                  item++)
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
                            Icons.account_circle_outlined,
                            color: Theme.of(context).accentColor,
                            size: 20,
                          )),
                      SizedBox(width: 4),
                      Text(selectedItemsList_Members[item].toString()),
                      SizedBox(width: 4),
                      InkWell(
                          child: Icon(
                            Icons.close,
                            size: 18,
                            color: Theme.of(context).accentColor,
                          ),
                          onTap: () {
                            setState(() {
                              selectedItemsList_Members
                                  .remove(selectedItemsList_Members[item]);
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
                itemCount: members.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () => selectTappedItem_Members(index),
                    title: Text('${members[index]}',
                        style: Theme.of(context).textTheme.bodyText1),
                    leading: Container(
                      padding: EdgeInsets.all(8),
                      decoration: selectedItemsList_Members
                              .contains(members[index])
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
                      child: !selectedItemsList_Members.contains(members[index])
                          ? Icon(Icons.account_circle)
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
              child: Text('Add Members'),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.transparent,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => newTask()));
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => SecondPage(data: data,)));
                data.added_members = List.from(selectedItemsList_Members);
              },
            ),
          )
        ],
      ),
    );
  }

  void selectTappedItem_Members(int index) {
    if (selectedItemsList_Members.contains(members[index])) {
      setState(() {
        selectedItemsList_Members.remove(members[index]);
      });
      print(selectedItemsList_Members);
    } else {
      setState(() {
        selectedItemsList_Members.add(members[index]);
      });
      print(selectedItemsList_Members);
    }
  }
}

//       data.added_members = List.from(selectedItemsList);
