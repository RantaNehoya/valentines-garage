import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //create user
  Future<String> createUser ({required BuildContext ctx, required String email, required String password, required String name}) async {
    String message = 'User successfully created';

    try{
      UserCredential authUser = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User user = authUser.user as User;
      await user.updateDisplayName(name);

    }on FirebaseAuthException catch(e){

      if(e.code == 'email-already-exists'){
        message = 'Email already exists';
      }
      else if(e.code == 'invalid-display-name'){
        message = 'Name is not valid';
      }
      else if(e.code == 'invalid-email'){
        message = 'Email is invalid';
      }
      else if(e.code == 'invalid-password'){
        message = 'Password must be at least 6 characters long';
      }
    }

    return message;
  }

  //change password
  Future<void> changePassword () async {
    await _firebaseAuth.sendPasswordResetEmail(
      email: _firebaseAuth.currentUser!.email as String,
    );
  }

  //sign out
  void logOut(){
    _firebaseAuth.signOut();
  }

  //get display name
  String getDisplayName() {
    return _firebaseAuth.currentUser!.displayName.toString();
  }

  //update display name
  Future updateDisplayName(String name) async {
    await _firebaseAuth.currentUser!.updateDisplayName(name);
  }

  //update profile picture
  Future updateProfilePicture(String path) async {
    await _firebaseAuth.currentUser!.updatePhotoURL(path);
  }

  //get profile picture
  String getProfilePicture() {
    return _firebaseAuth.currentUser!.photoURL.toString();
  }

  //update email address
  Future updateEmailAddress(String newEmail) async {
    await _firebaseAuth.currentUser!.updateEmail(newEmail);
  }

  //delete account
  Future deleteAccount() async {
    await _firebaseAuth.currentUser!.delete();
  }
}