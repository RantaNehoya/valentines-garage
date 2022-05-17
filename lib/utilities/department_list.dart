import 'package:flutter/material.dart';

class Department extends StatefulWidget {
  const Department({Key? key}) : super(key: key);

  @override
  _DepartmentState createState() => _DepartmentState();
}

class _DepartmentState extends State<Department> {
  List data = [
    'Electrical',
    'Mechanical',
    'Trailer',
  ];
  List selectedItemsList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor, title: Text("Department Page")),
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
                            Icons.business_center_outlined,
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
                          ? Icon(Icons.business_center)
                          : Icon(Icons.check, color: Colors.white),
                    ),
                  );
                }),
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
}
