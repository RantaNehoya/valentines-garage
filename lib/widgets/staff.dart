import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class Staff {
  //collection reference
  final CollectionReference _collectionReference = FirebaseFirestore.instance.collection('staff');

  Future<List> getFromFB () async {

    List staffDetails = [];
    QuerySnapshot querySnapshot = await _collectionReference.get();
    var qs = querySnapshot.docs.toList();

    for(var doc in qs){
      Map stffdtls = {
        'department': doc['department'],
        'email': doc['email'],
        'isManager': doc['isManager'],
        'name': doc['name'],
        'photoUrl': doc['photoUrl'],
        'uid': doc['uid'],
      };
      staffDetails.add(stffdtls);
    }

    return staffDetails;
  }
}

class ValentineViewStaff extends StatefulWidget {
  const ValentineViewStaff({Key? key}) : super(key: key);

  @override
  State<ValentineViewStaff> createState() => _ValentineViewStaffState();
}

class _ValentineViewStaffState extends State<ValentineViewStaff> {

  final _collectionReference = FirebaseFirestore.instance.collection('staff').orderBy('name');
  Staff staff = Staff();

  Widget readStaff (){
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

        return ListView(
          children: List.generate(
            snapshot.data!.length, (index){
            return Card(
              elevation: 2.0,
              child: ListTile(
                title: Text('${snapshot.data![index]['name']}'),
                subtitle: snapshot.data![index]['isManager'] ?
                Text('${snapshot.data![index]['department']} - Manager') : Text('${snapshot.data![index]['department']} - Employee'),

                leading: Image(
                  fit: BoxFit.contain,
                  width: 50.0,
                  image: snapshot.data![index]['photoUrl'] == '' ? const AssetImage('assets/images/unknown.png') : FileImage(File(snapshot.data![index]['photoUrl'])) as ImageProvider,
                ),

                trailing: Switch(
                  value: snapshot.data![index]['isManager'],
                  activeColor: Theme.of(context).primaryColorDark,
                  inactiveThumbColor: Theme.of(context).primaryColorLight,

                  onChanged: (selected) async {
                    QuerySnapshot qs = await _collectionReference.get();

                    setState(() {
                      snapshot.data![index]['isManager'] = selected;
                      qs.docs[index].reference.update({
                        'isManager': selected,
                      });
                    });
                  },
                ),
              ),
            );
          },),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColorDark,
          title: const Text('Staff'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_outlined),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
        ),
        body: readStaff(),
      ),
    );
  }
}


class ManagerViewStaff extends StatefulWidget {
  const ManagerViewStaff({Key? key}) : super(key: key);

  @override
  State<ManagerViewStaff> createState() => _ManagerViewStaffState();
}

class _ManagerViewStaffState extends State<ManagerViewStaff> {

  final _collectionReference = FirebaseFirestore.instance.collection('staff').orderBy('name');
  Staff staff = Staff();

  Widget readStaff (){
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

        return ListView(
          children: List.generate(
            snapshot.data!.length, (index){
            return Card(
              elevation: 2.0,
              child: ListTile(
                title: Text('${snapshot.data![index]['name']}'),
                subtitle: snapshot.data![index]['isManager'] ?
                Text('${snapshot.data![index]['department']} - Manager') : Text('${snapshot.data![index]['department']} - Employee'),

                leading: Image(
                  fit: BoxFit.contain,
                  width: 50.0,
                  image: snapshot.data![index]['photoUrl'] == '' ? const AssetImage('assets/images/unknown.png') : FileImage(File(snapshot.data![index]['photoUrl'])) as ImageProvider,
                ),
              ),
            );
          },),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColorDark,
          title: const Text('Staff'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_outlined),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
        ),
        body: readStaff(),
      ),
    );
  }
}