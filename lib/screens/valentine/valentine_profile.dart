import 'package:flutter/material.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

import 'package:valentines_garage/widgets/change_theme_button.dart';
import 'package:valentines_garage/utilities/shared_preferences.dart';
import 'package:valentines_garage/widgets/widgets.dart';

class ValentineProfile extends StatefulWidget {
  const ValentineProfile({Key? key}) : super(key: key);

  @override
  State<ValentineProfile> createState() => _ValentineProfileState();
}

class _ValentineProfileState extends State<ValentineProfile> {

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[

            Stack(
              alignment: Alignment.center,
              children: <Widget>[

                //profile background
                profileBackground(
                  ctx: context,
                ),

                //profile avatar
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[

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
                  ],
                ),

                profileName(
                  name: 'Valentine',
                ),
              ],
            ),

            GestureDetector(
              child: const Padding(
                padding: EdgeInsets.only(
                  top: 20.0,
                  bottom: 8.0,
                ),
                child: Text('Manage Staff',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              onTap: (){
                //todo: manage staff
              },
            ),

            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8.0,
              ),
              child: Divider(
                thickness: 1.0,
              ),
            ),

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
