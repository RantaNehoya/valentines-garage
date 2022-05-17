import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login/flutter_login.dart';

import 'package:valentines_garage/screens/valentine/valentine_page_navigation.dart';
import 'package:valentines_garage/screens/employees/employee_page_navigation.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  Duration get loginTime => const Duration(milliseconds: 2250);
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _valentineUID = 'KCpacq7f0CM6bkvBJr3DbxmHn5I2';

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

  //user auth log in
  // Future<String?> _signupUser(SignupData data) {
  //   debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
  //   return Future.delayed(loginTime).then((_) {
  //     return null;
  //   });
  // }

  //user uid
  String _userUID (){
    User? user = _firebaseAuth.currentUser;
    String? uid = user?.uid;
    return uid as String;
  }

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

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: FlutterLogin(
          title: 'Valentine\'s\nGarage',
          logo: const AssetImage('assets/images/mechanic.png'),
          navigateBackAfterRecovery: true,
          scrollable: true,
          messages: LoginMessages(
            recoverPasswordDescription: 'We will send an email to this email address',
            recoverPasswordSuccess: 'Email successfully sent',
          ),

          theme: LoginTheme(
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
                builder: (context) => _userUID() == _valentineUID ? const ValentinePageNavigation() : const EmployeePageNavigation(),
              ),
            );
          },
          onRecoverPassword: _recoverPassword,
        ),
      ),
    );
  }
}