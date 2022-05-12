import 'package:flutter/material.dart';

//design for the start screen buttons
Padding kStartScreenButton({required BuildContext ctx, required String user, required VoidCallback ftn}){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: MediaQuery.of(ctx).size.width * 0.8,
      height: MediaQuery.of(ctx).size.height * 0.07,

      child: OutlinedButton(
        child: Text(
          user,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 18.0,
          ),
        ),

        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),

          side: MaterialStateProperty.all(
            BorderSide(
              color: Theme.of(ctx).primaryColor,
              width: 1.0,
            ),
          ),

          foregroundColor: MaterialStateProperty.all(Colors.black),
        ),

        onPressed: ftn,
      ),
    ),
  );
}