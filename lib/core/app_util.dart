import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppUtil {
  static void showToast(
    String msg,
  ) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: Colors.blue,
      textColor: Colors.black,
      fontSize: 22,
    );
  }
}
