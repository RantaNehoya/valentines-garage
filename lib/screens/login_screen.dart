import 'package:flutter/material.dart';

import 'package:flutter_login/flutter_login.dart';

import 'package:valentines_garage/screens/valentine/valentine_page_navigation.dart';

//temp log in todo: remove
const users = {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  // Future<String?> _signupUser(SignupData data) {
  //   debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
  //   return Future.delayed(loginTime).then((_) {
  //     return null;
  //   });
  // }

  Future<String?> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.06),
        child: FlutterLogin(
          title: 'Valentine\'s\nGarage',
          logo: const AssetImage('assets/images/mechanic.png'),
          navigateBackAfterRecovery: true,
          scrollable: true,

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
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const ValentinePageNavigation(),
            ));
          },

          onRecoverPassword: _recoverPassword,
        ),
      ),
    );
  }
}