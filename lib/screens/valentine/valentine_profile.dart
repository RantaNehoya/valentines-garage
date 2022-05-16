import 'package:flutter/material.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

import 'package:valentines_garage/widgets/change_theme_button.dart';
import 'package:valentines_garage/widgets/widgets.dart';
import 'package:valentines_garage/widgets/constants.dart';
import 'package:valentines_garage/utilities/auth.dart';
import 'package:valentines_garage/screens/login_screen.dart';

class ValentineProfile extends StatefulWidget {
  const ValentineProfile({Key? key}) : super(key: key);

  @override
  State<ValentineProfile> createState() => _ValentineProfileState();
}

class _ValentineProfileState extends State<ValentineProfile> {

  @override
  void initState() {
    _loadImage();
    _auth.getDisplayName();
    super.initState();
  }

  //keys
  final _addAccountKey = GlobalKey<FormState>();
  final _changeNameKey = GlobalKey<FormState>();

  //auth
  final Authentication _auth = Authentication();
  String _newUserName = '';
  String _newUserEmail = '';
  String _newUserPassword = '';

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
                  position: 'Chief Executive Officer',
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
                'Manage Staff',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),

              //add account
              GestureDetector(
                child: const SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                      bottom: 8.0,
                    ),
                    child:  Text(
                      'Add User Account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (context){
                      return SingleChildScrollView(
                        child: AlertDialog(
                          title: const Text(
                            'Add new user',
                            textAlign: TextAlign.center,
                          ),
                          elevation: 2.0,
                          content: Form(
                            key: _addAccountKey,
                            child: Column(
                              children: <Widget>[

                                textFormInput(
                                  controller: _nameController,
                                  label: 'Name and Surname',
                                  autofcs: true,
                                  onSub: (_){
                                    setState(() {
                                      FocusScope.of(context).requestFocus(_emailFocusNode);
                                    });
                                  },
                                ),

                                textFormInput(
                                  controller: _emailController,
                                  label: 'Email Address',
                                  focusNode: _emailFocusNode,
                                  keyboard: TextInputType.emailAddress,
                                  onSub: (_){
                                    setState(() {
                                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                                    });
                                  },
                                ),

                                textFormInput(
                                  controller: _passwordController,
                                  label: 'Password',
                                  focusNode: _passwordFocusNode,
                                  obscureTxt: true,
                                  onSub: (_){
                                    setState(() {
                                      FocusScope.of(context).unfocus();
                                    });
                                  },
                                ),

                                //button
                                Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: OutlinedButton(
                                      child: const Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text('Create User'),
                                      ),
                                      onPressed: () {
                                        if(_addAccountKey.currentState!.validate()){
                                          setState(() async {
                                            _newUserName = _nameController.text;
                                            _newUserEmail = _emailController.text;
                                            _newUserPassword = _passwordController.text;

                                            String msg = await _auth.createUser(
                                              ctx: context,
                                              email: _newUserEmail,
                                              password: _newUserPassword,
                                              name: _newUserName,
                                            );

                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                duration: const Duration(seconds: 2),
                                                content: Text(msg),
                                                behavior: SnackBarBehavior.floating,
                                              ),
                                            );

                                            _nameController.clear();
                                            _emailController.clear();
                                            _passwordController.clear();
                                            Navigator.of(context).pop();
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
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
