import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_texi_app/models/user_model.dart';

class MyVariables {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static Future<UserModel?> myUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return UserModel(
        name: "UserName",
        profilePic: '',
        uid: user.uid,
        email: user.email,
      );
    }
    return null;
  }

  static Stream<QuerySnapshot> bookingHistryStream(String uid) {
    return MyVariables.firestore
        .collection("bookings")
        .where("userId", isEqualTo: uid.toString())
        .snapshots();
  }
}
