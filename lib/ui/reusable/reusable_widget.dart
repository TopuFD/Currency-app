import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReWidget{
  myToast(String message){
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.red,
        fontSize: 20.0,
        
    );
  }
}