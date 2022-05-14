import 'package:flutter/material.dart';

import 'package:avatar_glow/avatar_glow.dart';


//design for the profile avatar
Padding profileAvatar({required BuildContext ctx, required ImageProvider avatar}){
  return Padding(
    padding: const EdgeInsets.only(
      top: 5.0,
      bottom: 40.0,
    ),

    child: AvatarGlow(
      glowColor: Theme.of(ctx).primaryColor,
      endRadius: 70.0,

      child: CircleAvatar(
        backgroundColor: Colors.grey[100],
        radius: MediaQuery.of(ctx).size.width * 0.13,

        foregroundImage: avatar,
      ),
    ),
  );
}

//profile name
Positioned profileName({required String name}){
  return Positioned(
    bottom: 10.0,
    child: Text(
      name,
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

//profile background
Container profileBackground ({required BuildContext ctx}){
  return Container(
    color: Theme.of(ctx).primaryColorDark,
    width: double.infinity,
    height: MediaQuery.of(ctx).size.height * 0.25,
  );
}

//profile picture button
MaterialButton imageButton ({required String src, required VoidCallback imageSource, required IconData icon}){
  return MaterialButton(
    child: Card(
      elevation: 1.0,
      child: ListTile(
        leading: Icon(
          icon,
          size: 30.0,
        ),
        title: Text(src),
      ),
    ),

    onPressed: imageSource,
  );
}

//edit button
IconButton editButton ({required BuildContext ctx, required MaterialButton galleryButton, required MaterialButton cameraButton}){
  return IconButton(
    icon: const Icon(Icons.edit_outlined),
    color: Colors.white,
    iconSize: MediaQuery.of(ctx).size.width * 0.13,
    onPressed: (){
      showModalBottomSheet(
        context: ctx,
        builder: (ctx){
          return SizedBox(
            height: 250.0,
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20.0,
                  ),
                  child: Text(
                    'Select New Avatar',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                galleryButton,

                SizedBox(
                  height: MediaQuery.of(ctx).size.height * 0.01,
                ),

                cameraButton,
              ],
            ),
          );
        },
      );
    },
  );
}