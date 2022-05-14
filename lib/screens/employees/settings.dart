import 'package:flutter/material.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

import 'package:valentines_garage/widgets/change_theme_button.dart';
import 'package:valentines_garage/utilities/shared_preferences.dart';
import 'package:valentines_garage/widgets/widgets.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[

          Stack(
            alignment: Alignment.center,
            children: <Widget>[

              //profile background
              profileBackground(
                  ctx: context
              ),

              //profile avatar
              profileAvatar(
                ctx: context,
                avatar: AvatarImage.imgPath.isEmpty ? const AssetImage('assets/images/unknown.png') : FileImage(File(AvatarImage.imgPath)) as ImageProvider,
              ),

              editButton(
                ctx: context,
                galleryButton: imageButton(
                  src: 'Image from Gallery',
                  imageSource: _imageFromGallery,
                  icon: Icons.photo,
                ),
                cameraButton: imageButton(
                  src: 'Image from Gallery',
                  imageSource: _imageFromCamera,
                  icon: Icons.add_a_photo,
                ),
              ),

              const Positioned(
                bottom: 10.0,
                child: Text('John Doe',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Row(
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
          ),
        ],
      ),
    );
  }

  //retrieve image from gallery
  Future _imageFromGallery() async {
    AvatarImage.image = await ImagePicker().pickImage(source: ImageSource.gallery);

    AvatarImage.saveImage = await SharedPreferences.getInstance();

    if(AvatarImage.image != null){
      setState(() {
        AvatarImage.imageFile = AvatarImage.image as XFile;
        Navigator.of(context).pop();
      });
    }

    AvatarImage.saveImage.setString("imgPath", AvatarImage.imageFile.path);

    print(
      '''
      *******************************************
      PATH: ${AvatarImage.imageFile.path}
      *******************************************
      ''',
    );

    setState(() {
      AvatarImage.imagePath = AvatarImage.saveImage.getString("imgPath") as String;
    });
  }

  //retrieve image from camera
  Future _imageFromCamera() async {
    AvatarImage.image = await ImagePicker().pickImage(source: ImageSource.camera);

    AvatarImage.saveImage = await SharedPreferences.getInstance();

    if(AvatarImage.image != null){
      setState(() {
        AvatarImage.imageFile = AvatarImage.image as XFile;
        Navigator.of(context).pop();
      });
    }

    AvatarImage.saveImage.setString("imgPath", AvatarImage.imageFile.path);

    print(
      '''
      *******************************************
      PATH: ${AvatarImage.imageFile.path}
      *******************************************
      ''',
    );

    setState(() {
      AvatarImage.imagePath = AvatarImage.saveImage.getString("imgPath") as String;
    });
  }


  //load image on app startup
  void _loadImage() async {
    SharedPreferences saveImage = await SharedPreferences.getInstance();

    setState(() {
      AvatarImage.imgPath = saveImage.getString("imgPath") as String;
    });
  }
}
