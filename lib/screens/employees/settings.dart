import 'package:flutter/material.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

import 'package:valentines_garage/widgets/change_theme_button.dart';
import 'package:valentines_garage/widgets/widgets.dart';
import 'package:valentines_garage/utilities/auth.dart';
import 'package:valentines_garage/widgets/constants.dart';
import 'package:valentines_garage/screens/login_screen.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  void initState() {
    _loadImage();
    _auth.getDisplayName();
    super.initState();
  }

  //keys
  final _changeEmailKey = GlobalKey<FormState>();
  final _changeNameKey = GlobalKey<FormState>();

  //auth
  final Authentication _auth = Authentication();
  String _imagePath = '';

  //controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  //focus nodes
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    //dispose controllers
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _newPasswordController.dispose();

    //dispose focus nodes
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[

              profileSetup(
                ctx: context,

                //light/dark mode
                themePosition: themePosition(
                  child: const ChangeThemeButtonIcon(),
                ),

                //todo: picture
                //profile avatar
                avatarPicture: profileAvatar(
                  ctx: context,
                  avatar: _auth.getProfilePicture().isEmpty ? const AssetImage('assets/images/unknown.png') : FileImage(File(_auth.getProfilePicture())) as ImageProvider,
                  gallerySheetButton: imageButton(
                    ctx: context,
                    icon: Icons.photo,
                    src: 'Image from Gallery',
                    imageSource: _imageFromGallery,
                  ),
                  cameraSheetButton: imageButton(
                    ctx: context,
                    icon: Icons.add_a_photo,
                    src: 'Image from Camera',
                    imageSource: _imageFromCamera,
                  ),
                ),

                //position
                companyPosition: companyPosition(
                  ctx: context,
                  position: 'Staff',
                ),

                profileName: profileName(
                  ctx: context,
                  name: _auth.getDisplayName(),
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),

              //todo: name
              //change name
              settingPageManagement(
                ctx: context,
                ftn: 'Change name',
                head: const Text(
                  'Change name',
                  textAlign: TextAlign.center,
                ),
                child: Form(
                  key: _changeNameKey,
                  child: TextFormField(
                    autofocus: true,
                    controller: _nameController,
                    textInputAction: TextInputAction.done,
                    validator: (input){
                      if(input == null || input.isEmpty) {
                        return 'Cannot leave field empty';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'User Name',
                    ),

                    onFieldSubmitted: (_){
                      if(_changeNameKey.currentState!.validate()){
                        _auth.updateDisplayName(_nameController.text);
                        _nameController.clear();
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ),
              ),
              kDivider,

              //change email
              settingPageManagement(
                ctx: context,
                ftn: 'Change email',
                head: const Text(
                  'Change email',
                  textAlign: TextAlign.center,
                ),
                child: Form(
                  key: _changeEmailKey,
                  child: TextFormField(
                    autofocus: true,
                    controller: _emailController,
                    textInputAction: TextInputAction.done,
                    validator: (input){
                      if(input == null || input.isEmpty) {
                        return 'Cannot leave field empty';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'New Email',
                    ),

                    onFieldSubmitted: (_){
                      if(_changeEmailKey.currentState!.validate()){
                        _auth.updateEmailAddress(_emailController.text);
                        _emailController.clear();
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ),
              ),
              kDivider,

              //change password
              settingPageManagement(
                ctx: context,
                ftn: 'Change password',
                child: const Text(
                  'Your password reset instructions will be sent to your email. Do you wish to continue?',
                  textAlign: TextAlign.center,
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: <Widget>[
                      OutlinedButton(
                        onPressed: (){
                          _auth.changePassword();
                          Navigator.of(context).pop();
                        },
                        child: const Text('Yes'),
                      ),

                      OutlinedButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        child: const Text('No, Thanks'),
                      ),
                    ],
                  ),
                ],
              ),
              kDivider,

              //log out
              settingPageManagement(
                ctx: context,
                ftn: 'Log out',
                child: const Text('Do you wish to log out?'),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                        onPressed: (){
                          _auth.logOut();

                          //navigate to login screen
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: const Text('Yes'),
                      ),

                      OutlinedButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        child: const Text('No'),
                      ),
                    ],
                  ),
                ],
              ),
              kDivider,

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),

              //manage staff
              const Text(
                'Danger Zone',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),

              //delete account
              settingPageManagement(
                ctx: context,
                ftn: 'Delete Account',
                child: const Text(
                  'Do you wish to delete your account?\nThis action is irreversible',
                  textAlign: TextAlign.center,
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: <Widget>[

                      OutlinedButton(
                        onPressed: (){
                          _auth.deleteAccount();

                          //navigate to login screen
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: const Text('Yes'),
                      ),

                      OutlinedButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        child: const Text('No, Thanks'),
                      ),
                    ],
                  ),
                ],
              ),
              kDivider,

              //change theme
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const <Widget>[
                  Text('Change Theme',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),

                  ChangeThemeButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //retrieve image from gallery
  Future _imageFromGallery() async {
    late XFile _imageFile;
    XFile? image;
    late SharedPreferences saveImage;

    image = await ImagePicker().pickImage(source: ImageSource.gallery);
    saveImage = await SharedPreferences.getInstance();

    if(image != null){
      setState(() {
        _imageFile = image as XFile;
        Navigator.of(context).pop();
      });
    }

    saveImage.setString("imgPath", _imageFile.path);

    setState(() {
      _imagePath = saveImage.getString("imgPath") as String;
      _auth.updateProfilePicture(_imagePath);
    });
  }

  // retrieve image from camera
  Future _imageFromCamera() async {
    late XFile _imageFile;
    XFile? image;
    late SharedPreferences saveImage;

    image = await ImagePicker().pickImage(source: ImageSource.camera);
    saveImage = await SharedPreferences.getInstance();

    if(image != null){
      setState(() {
        _imageFile = image as XFile;
        Navigator.of(context).pop();
      });
    }

    saveImage.setString("imgPath", _imageFile.path);

    setState(() {
      _imagePath = saveImage.getString("imgPath") as String;
      _auth.updateProfilePicture(_imagePath);
    });
  }

  //load image on app startup
  void _loadImage() async {
    SharedPreferences saveImage = await SharedPreferences.getInstance();

    setState(() {
      _imagePath = saveImage.getString("imgPath") as String;
    });
  }
}
