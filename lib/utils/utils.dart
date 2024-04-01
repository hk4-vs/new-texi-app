import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils{
   static void changeFocusNext(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
   static toastMessage(String message) {
    Fluttertoast.showToast(msg: message);
  }

  static void showSnackBar(BuildContext context, String message) {
    showSnackBar(context, message);
  }

  static int randomNumber(){
      Random random = Random();
    int min = 5;
    int max = 20;

    int randomNumber = min + random.nextInt(max - min + 1);
    return randomNumber;
  }
  static String formateDate(String date){
  DateTime now=  DateTime.parse(date);
  return "${now.day}/${now.month}/${now.year}";
  }
static String formateTime(String date) {
    DateTime now = DateTime.parse(date);
    return "${now.hour}:${now.minute}:${now.second}";
  }
 
}