import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyToaster {
  static void showToaster(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}