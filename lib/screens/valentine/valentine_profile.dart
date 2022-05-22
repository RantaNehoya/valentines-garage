import 'package:flutter/material.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

import 'package:valentines_garage/widgets/change_theme_button.dart';
import 'package:valentines_garage/widgets/staff.dart';
import 'package:valentines_garage/widgets/widgets.dart';
import 'package:valentines_garage/widgets/constants.dart';
import 'package:valentines_garage/utilities/auth.dart';
import 'package:valentines_garage/screens/login_screen.dart';
import 'package:valentines_garage/utilities/pdf_report.dart';

class ValentineProfile extends StatefulWidget {
  const ValentineProfile({Key? key}) : super(key: key);

  @override
  State<ValentineProfile> createState() => _ValentineProfileState();
}

class _ValentineProfileState extends State<ValentineProfile> {

  final Authentication _auth = Authentication();

  String _imagePath = '';
  String _name = '';

  //controllers
  final TextEditingController _nameController = TextEditingController();

  //keys
  final _changeNameKey = GlobalKey<FormState>();

  @override
  void initState() {
    _auth.getDisplayName();
    _name = _auth.getDisplayName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _name = _auth.getDisplayName();

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

                //name
                profileName: profileName(
                  ctx: context,
                  name: _name,
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),

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
                  child: textFormInput(
                    ctx: context,
                    label: 'User Name',
                    controller: _nameController,
                    autofcs: true,
                    keyboard: TextInputType.name,

                    onSub: (_){
                      if(_changeNameKey.currentState!.validate()){
                        setState(() {
                          _auth.updateDisplayName(_nameController.text);
                          _nameController.clear();
                          Navigator.of(context).pop();
                        });
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
                        child: Text(
                          'Yes',
                          style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                      ),

                      OutlinedButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'No, Thanks',
                          style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
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
                child: const Text(
                  'Do you wish to log out?',
                  textAlign: TextAlign.center,
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                        onPressed: (){
                          _auth.logOut();

                          //navigate to login screen
                          Navigator.of(context).pop();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Yes',
                          style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                      ),

                      OutlinedButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'No',
                          style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
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
                      return const SingleChildScrollView(
                        child: AccountDialog(),
                      );
                    },
                  );
                },
              ),
              kDivider,

              //view staff members
              GestureDetector(
                child: const SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                      bottom: 8.0,
                    ),
                    child:  Text(
                      'View Staff',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context){
                        return const ValentineViewStaff();
                      }),
                    ),
                  );
                },
              ),
              kDivider,

              //generate report
              GestureDetector(
                child: const SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                      bottom: 8.0,
                    ),
                    child:  Text(
                      'Generate report',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
                onTap: () async {
                  createPDF(ctx: context);
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
  // void _loadImage() async {
  //   SharedPreferences saveImage = await SharedPreferences.getInstance();
  //
  //   setState(() {
  //     _imagePath = saveImage.getString("imgPath") as String;
  //   });
  // }
}

class AccountDialog extends StatefulWidget {
  const AccountDialog({Key? key}) : super(key: key);

  @override
  State<AccountDialog> createState() => _AccountDialogState();
}

class _AccountDialogState extends State<AccountDialog> {

  //keys
  final _addAccountKey = GlobalKey<FormState>();

  //auth
  final Authentication _auth = Authentication();

  List<Map<String, dynamic>> departments = [
    {
      'department': 'Electrical',
      'isSelected': false,
    },
    {
      'department': 'Mechanical',
      'isSelected': false,
    },
    {
      'department': 'Trailer',
      'isSelected': false
    },
  ];
  //new user
  String _newUserName = '';
  String _newUserEmail = '';
  String _newUserPassword = '';
  String staffDepartment = '';
  bool _isObscure = true;
  bool isManager = false;

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
    return AlertDialog(
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
              ctx: context,
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
              ctx: context,
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

            TextFormField(
              cursorColor: Theme.of(context).primaryColorDark,
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              obscureText: _isObscure,
              validator: (input){
                if(input == null || input.isEmpty) {
                  return 'Cannot leave field empty';
                }
                return null;
              },

              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontSize: 12,
                ),

                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColorDark,
                    width: 2.0,
                  ),
                ),

                suffixIcon: IconButton(
                  icon: _isObscure ? const Icon(Icons.visibility_outlined) : const Icon(Icons.visibility_off_outlined),
                  color: Theme.of(context).primaryColorDark,

                  onPressed: (){
                    setState(() {
                      _isObscure = _isObscure ? _isObscure = false : _isObscure = true;
                    });
                  },
                ),
              ),

              onFieldSubmitted: (_){
                setState(() {
                  FocusScope.of(context).unfocus();
                });
              },
            ),

            //department chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,

              child: Row(
                children: List.generate(
                  departments.length, (index){
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ChoiceChip(
                      label: Text('${departments[index]['department']}'),
                      selected: departments[index]['isSelected'],
                      backgroundColor: Theme.of(context).primaryColorLight,
                      selectedColor: Theme.of(context).primaryColorDark,

                      onSelected: (selected){
                        setState(() {
                          for (int i=0; i<departments.length; i++){
                            departments[i]['isSelected'] = false;
                          }
                          departments[index]['isSelected'] = selected;
                          staffDepartment = departments[index]['department'];
                        });
                      },
                    ),
                  );
                },),
              ),
            ),

            //manager switch
            SwitchListTile(
              title: const Text('Manager'),
              selected: isManager,
              value: isManager,
              activeColor: Theme.of(context).primaryColorDark,
              inactiveThumbColor: Theme.of(context).primaryColorLight,
              secondary: const Icon(Icons.account_circle_outlined),

              onChanged: (bool value){
                setState(() {
                  isManager = value;
                });
              },
            ),

            //button
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: Theme.of(context).primaryColorLight,
                  ),

                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('Create User'),
                  ),

                  onPressed: () async {

                    if(_addAccountKey.currentState!.validate()){
                      setState(() {
                        _newUserName = _nameController.text;
                        _newUserEmail = _emailController.text;
                        _newUserPassword = _passwordController.text;
                      });

                      String msg = await _auth.createUser(
                        ctx: context,
                        email: _newUserEmail,
                        password: _newUserPassword,
                        name: _newUserName,
                        isManager: isManager,
                        department: staffDepartment,
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
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

