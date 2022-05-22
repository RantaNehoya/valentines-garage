import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Staff {
  //collection reference
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('staff');

  Future<List> readFromFB () async {
    List<Map<String, dynamic>> stffDetails = [];
    QuerySnapshot qs = await collectionReference.get();

    if (qs.docs.isNotEmpty){
      debugPrint('HERE 1');
      for(var doc in qs.docs.toList()){
        debugPrint('HERE 2');
        Map<String, dynamic> staffDetails = {
          'department': doc['department'],
          'email': doc['email'],
          'isManager': doc['isManager'],
          'name': doc['name'],
          'photoUrl': doc['photoUrl'],
          'uid': doc['uid'],
        };
        debugPrint('HERE 3');
        stffDetails.add(staffDetails);
      }
    }
    return stffDetails;
  }
}

class StaffCard extends StatefulWidget {
  const StaffCard({Key? key}) : super(key: key);

  @override
  State<StaffCard> createState() => _StaffCardState();
}

class _StaffCardState extends State<StaffCard> {

  bool _isLoading = true;
  List stffDtls = [];

  void getDB () {
    Staff stffDtails = Staff();
    setState(() {
      stffDtails.readFromFB().then((value) =>{
        stffDtls = value
      });
    });
  }

  @override
  void initState() {
    getDB();
    Timer(const Duration(seconds: 3), (){
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
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
        body: _isLoading ? Center(
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
            color: Theme.of(context).primaryColorDark,
          ),
        )
            :
        ListView(
          children: List.generate(
            stffDtls.length, (index){
            return Card(
              elevation: 2.0,
              child: ListTile(
                title: Text('${stffDtls[index]['name']}'),
                subtitle: stffDtls[index]['isManager'] ?
                Text('${stffDtls[index]['department']} - Manager') : Text('${stffDtls[index]['department']} - Employee'),

                leading: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Image(
                    image: NetworkImage(
                        '${stffDtls[index]['photoUrl']}'
                    ),
                  ),
                ),

                trailing: Switch(
                  value: stffDtls[index]['isManager'],
                  activeColor: Theme.of(context).primaryColorDark,
                  inactiveThumbColor: Theme.of(context).primaryColorLight,

                  onChanged: (selected){
                    setState(() {
                      stffDtls[index]['isManager'] = selected;
                    });
                  },
                ),
              ),
            );
          },),
        ),
      ),
    );
  }
}
