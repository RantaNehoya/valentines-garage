import 'dart:io';

import 'package:flutter/material.dart';

import '../../utilities/auth.dart';
import '../../widgets/staff.dart';
import 'new_task.dart';


class assignPage extends StatefulWidget {
  assignPage({Key? key}) : super(key: key);
  List selectedItemsList = [];

  @override
  _assignPageState createState() => _assignPageState();
}

class _assignPageState extends State<assignPage> {

  final Authentication _auth = Authentication();
  Staff staff = Staff();



  Widget getStaff(){
    return FutureBuilder(
      future: staff.getFromFB(),

      builder: (context, AsyncSnapshot<List> snapshot){

        if (snapshot.connectionState == ConnectionState.none && !snapshot.hasData){
          return const Center(
            child: Text('Oh no... there seems to be an error...'),
          );
        }
        else if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              color: Theme.of(context).primaryColorDark,
            ),
          );
        }

        List? snapshots = snapshot.data;

        Future.delayed(Duration(seconds: 1)).then((_){});

        void selectTappedItem(int index) {
          if (widget.selectedItemsList.contains(snapshots?[index]['name'])) {
            setState(() {
              widget.selectedItemsList.remove(snapshots?[index]['name']);
            });
          } else {
            setState(() {
              widget.selectedItemsList.add(snapshots?[index]['name']);
            });
          }
        }

        return Column(
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
                for (var item = 0; item < widget.selectedItemsList.length; item++)
                  Container(
                    margin: EdgeInsets.only(right: 8, top: 8),
                    padding: EdgeInsets.only(right: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Theme.of(context).primaryColorLight.withOpacity(0.3)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.all(4),
                          child: ClipOval(
                            child: Image(
                              width: 30.0,
                              height: 30.0,
                              image: snapshots?[item]['photoUrl'] == '' ? const AssetImage('assets/images/unknown.png') : FileImage(File(snapshots?[item]['photoUrl'])) as ImageProvider,
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(widget.selectedItemsList[item].toString()),
                        SizedBox(width: 4),
                        InkWell(
                          child: Icon(
                            Icons.close,
                            size: 18,
                            color: Theme.of(context).primaryColorLight,
                          ),
                          onTap: () {
                            setState(() {
                              widget.selectedItemsList.remove(widget.selectedItemsList[item]);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
              ]),
            ),
            Divider(
                color: Theme.of(context).primaryColorLight.withOpacity(0.6),
                endIndent: 16,
                thickness: 1,
                indent: 16),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                  itemCount: snapshots?.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () => selectTappedItem(index),
                      title: Text('${snapshots?[index]['name']}',
                          style: Theme.of(context).textTheme.bodyText1),
                      leading: Container(
                        padding: EdgeInsets.all(8),
                        decoration: widget.selectedItemsList.contains(snapshots?[index]['name'])
                            ? BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColorLight
                                .withOpacity(0.8))
                            : BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColorLight
                                .withOpacity(0.3)),
                        child: !widget.selectedItemsList.contains(snapshots?[index]['name'])
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
                color: Theme.of(context).primaryColorDark,
              ),
              child: TextButton(
                child: Text('Add Employees'),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.transparent,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColorDark,
          title: Text('Assign Employees')),
      body: getStaff(),
    );
  }
}
