import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_texi_app/models/user_model.dart';

import '../utils/routes/route_names.dart';

class AuthViewModel with ChangeNotifier {
  // static UserModel? _user = UserModel();

  // static UserModel? get user => _user;
  // setUserMode(UserModel user){
  //   _user = user;
  //   notifyListeners();
  // }

  isAlreadyLoggedIn({required BuildContext context}) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      log("user: ${user.uid}");
      UserModel userModel = UserModel(
        uid: user.uid,
        email: user.email,
        name: "UserName",
        profilePic: '',
        password: '',
      );
      // setUserMode(userModel);
      log("already logged in");
      Navigator.pushReplacementNamed(context, RouteNames.dashboard,
          arguments: {'user': userModel});
    } else {
      Navigator.pushReplacementNamed(
        context,
        RouteNames.login,
      );
    }
  }
}
