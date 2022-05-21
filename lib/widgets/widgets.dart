import 'package:flutter/material.dart';

import 'package:avatar_glow/avatar_glow.dart';

//design for the profile avatar
GestureDetector profileAvatar({required BuildContext ctx, required ImageProvider avatar, required MaterialButton gallerySheetButton, required MaterialButton cameraSheetButton}){
  return GestureDetector(
    child: Padding(
      padding: const EdgeInsets.only(
        top: 5.0,
        bottom: 60.0,
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
    ),

    onTap: (){
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

                gallerySheetButton,
                SizedBox(
                  height: MediaQuery.of(ctx).size.height * 0.01,
                ),
                cameraSheetButton,
              ],
            ),
          );
        },
      );
    },
  );
}

//profile name
Positioned profileName({required String name, required BuildContext ctx}){
  return Positioned(
    bottom: 10.0,
    child: SizedBox(
      width: MediaQuery.of(ctx).size.width * 1,
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

//profile background
Container profileSetup ({required BuildContext ctx, required Padding themePosition, required GestureDetector avatarPicture, required Positioned companyPosition, required Positioned profileName}){
  return Container(
    color: Theme.of(ctx).primaryColorDark,
    width: double.infinity,
    height: MediaQuery.of(ctx).size.height * 0.3,
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[

        //light/dark mode
        themePosition,

        //profile avatar
        avatarPicture,

        //position
        companyPosition,

        profileName,
      ],
    ),
  );
}

//app theme position
Padding themePosition ({required Widget child}){
  return Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 5.0,
      horizontal: 15.0,
    ),
    child: Align(
      alignment: Alignment.topRight,
      child: child,
    ),
  );
}

//bottomsheet profile picture button
MaterialButton imageButton ({required BuildContext ctx, required String src, required VoidCallback imageSource, required IconData icon}){
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

//company position
Positioned companyPosition ({required BuildContext ctx, required String position}){
  return Positioned(
    bottom: MediaQuery.of(ctx).size.height * 0.06,

    child: Container(
      decoration: BoxDecoration(
        color: Theme.of(ctx).primaryColorLight,
        borderRadius: BorderRadius.circular(30.0),
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 8.0,
        ),

        child: Text(position),
      ),
    ),
  );
}

TextFormField textFormInput ({bool autofcs=false, TextInputType? keyboard, FocusNode? focusNode, void Function(String)? onSub, required BuildContext ctx, required String label, required TextEditingController controller}){
  return TextFormField(
    cursorColor: Theme.of(ctx).primaryColorDark,
    textCapitalization: TextCapitalization.words,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: Theme.of(ctx).primaryColorLight,
        fontSize: 12,
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(ctx).primaryColorDark,
          width: 2.0,
        ),
      ),
    ),
    controller: controller,
    focusNode: focusNode,
    validator: (input){
      if(input == null || input.isEmpty) {
        return 'Cannot leave field empty';
      }
      return null;
    },
    keyboardType: keyboard,
    autofocus: autofcs,
    onFieldSubmitted: onSub,
  );
}

//settings options
GestureDetector settingPageManagement ({List<Widget>? actions, Text? head, required String ftn, required BuildContext ctx, required Widget child}){
  return GestureDetector(
    child: SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
          bottom: 8.0,
        ),
        child:  Text(
          ftn,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15.0,
          ),
        ),
      ),
    ),

    onTap: (){
      showDialog(
        context: ctx,
        builder: (ctx){
          return AlertDialog(
            title: head,
            elevation: 2.0,
            actions: actions,
            content: child,
          );
        },
      );
    },
  );
}
