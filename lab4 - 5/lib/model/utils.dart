import 'package:flutter/material.dart';

class Assets{

  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String? text){
    if(text == null) return;
    
    final snackBar = SnackBar(
      backgroundColor: Colors.deepOrange,
      content: Text(text),
      
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}