import 'package:flutter/material.dart';

class EmployeeTasks extends StatelessWidget {
  const EmployeeTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: const Text('Assigned Tasks'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Employee Assigned Tasks'),
          ],
        ),
      ),
    );
  }
}
