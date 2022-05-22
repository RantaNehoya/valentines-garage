import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login/flutter_login.dart';

import 'package:valentines_garage/screens/valentine/valentine_page_navigation.dart';
import 'package:valentines_garage/screens/employees/employee_page_navigation.dart';
import 'package:valentines_garage/screens/managers/manager_navigation.dart';
import 'package:valentines_garage/widgets/staff.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Staff staff = Staff();
  List managers = [];

  Duration get loginTime => const Duration(milliseconds: 2250);

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final _valentineUID = 'zXs0A1f7GjXNdoZg0sVBK0blobF2';

  //user auth sign in
  Future<String?> _authUser(LoginData data) async {
    debugPrint('Name: ${data.name}, Password: ${data.password}');

    try{
      await _firebaseAuth.signInWithEmailAndPassword(
        email: data.name,
        password: data.password,
      );
    }on FirebaseAuthException catch(e){
      return Future.delayed(loginTime).then((_) {
        if (e.code == 'user-not-found') {
          return 'User does not exist';
        }
        if (e.code == 'wrong-password') {
          return 'Password does not match';
        }
        return null;
      });
    }
    return null;
  }

  //user auth sign up
  String _userUID (){
    User? user = _firebaseAuth.currentUser;
    String? uid = user?.uid;
    return uid as String;
  }

  //recover password
  Future<String?> _recoverPassword(String name) async {
    try{
      await _firebaseAuth.sendPasswordResetEmail(
        email: name,
      );
    }on FirebaseAuthException catch(e){
      return Future.delayed(loginTime).then((_) {
        if (e.code == 'user-not-found') {
          return 'User does not exist';
        }
        return null;
      });
    }
    return null;
  }

  //future builder
  Widget userScreen (){
    return FutureBuilder(
      future: staff.getFromFB(),

      builder: (context, AsyncSnapshot<List> snapshot){

        List? snapshots = snapshot.data;

        Future.delayed(Duration(seconds: 1)).then((_){
          for(var snap in snapshots!){
            if(snap['isManager'] == true){
              managers.add(snap['uid']);
            }
          }
        });

        return FlutterLogin(
          title: 'Valentine\'s\nGarage',
          logo: const AssetImage('assets/images/mechanic.png'),
          navigateBackAfterRecovery: true,
          scrollable: true,

          messages: LoginMessages(
            recoverPasswordDescription: 'We will send an email to this email address',
            recoverPasswordSuccess: 'Email successfully sent',
          ),

          theme: LoginTheme(
            primaryColor: Theme.of(context).primaryColor,
            pageColorLight: Theme.of(context).primaryColor,
            pageColorDark: Theme.of(context).primaryColorDark,

            titleStyle: const TextStyle(
              fontFamily: 'Bungee',
            ),
          ),

          //login
          onLogin: _authUser,

          //sign up
          // onSignup: _signupUser,

          onSubmitAnimationCompleted: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                //if valentine send to manager page else employee page
                builder: (context) {
                  // for
                  if (_userUID() == _valentineUID){
                    return const ValentinePageNavigation();
                  }

                  else if (managers.contains(_userUID())){
                    return const ManagerPageNavigation();
                  }

                  else{
                    return const EmployeePageNavigation();
                  }
                },
              ),
            );
          },
          onRecoverPassword: _recoverPassword,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: userScreen(),
      ),
    );
  }
}