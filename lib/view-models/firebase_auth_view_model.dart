import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_model.dart';
import '../utils/routes/route_names.dart';
import '../utils/utils.dart';

class FirebaseAuthViewModel with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  setLoding(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  registerAccount(
      {required String email,
      required String password,
      required BuildContext context}) async {
    setLoding(true);
    UserCredential? userCredential;
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user!.email!.isNotEmpty) {
        String? uid = userCredential.user!.uid.toString();
        UserModel newUser = UserModel(
            email: email,
            password: password,
            uid: uid,
            name: "UserName",
            profilePic: '');
        log("uid: $uid");
        log("newUser: ${newUser.toMap()}");

        storeUserDataToFireStore(newUser: newUser);

        log("uid after firestore: $uid");
        setLoding(false);
        Navigator.pushNamedAndRemoveUntil(
            // ignore: use_build_context_synchronously
            context,
            RouteNames.dashboard,
            (Route<dynamic> route) => false,
            arguments: {
              'user': newUser,
            });
      }
    } on FirebaseAuthException catch (e) {
      setLoding(false);
      Utils.toastMessage(e.message.toString());
    } catch (e) {
      setLoding(false);
      Utils.toastMessage(e.toString());
    }
  }

  storeUserDataToFireStore({required UserModel newUser}) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(newUser.uid.toString())
        .set(newUser.toMap());
  }

  loginUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    setLoding(true);
    UserCredential? userCredential;
    try {
      userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user!.email!.isNotEmpty) {
        String? uid = userCredential.user!.uid.toString();
        UserModel user = UserModel(
            email: email,
            password: password,
            uid: uid,
            name: "UserName",
            profilePic: '');
        log("uid: $uid");
        log("user: ${user.toMap()}");

        log("uid after firestore: $uid");
        setLoding(false);
        Navigator.pushNamedAndRemoveUntil(
            // ignore: use_build_context_synchronously
            context,
            RouteNames.dashboard,
            (Route<dynamic> route) => false,
            arguments: {
              'user': user,
            });
      }
    } on FirebaseAuthException catch (e) {
      setLoding(false);
      Utils.toastMessage(e.message.toString());
    } catch (e) {
      setLoding(false);
      Utils.toastMessage(e.toString());
    }
  }

  Future<void> signInWithGoogle({
    required BuildContext context,
  }) async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
        UserModel newUser = UserModel(
            email: "email@email.com",
            password: "123456",
            uid: FirebaseAuth.instance.currentUser!.uid,
            name: "UserName",
            profilePic: '');
        storeUserDataToFireStore(newUser: newUser);

        Navigator.pushNamedAndRemoveUntil(
            // ignore: use_build_context_synchronously
            context,
            RouteNames.dashboard,
            (Route<dynamic> route) => false,
            arguments: {
              'user': newUser,
            });
      } else {
        // User cancelled the sign-in flow
      }
    } catch (e) {
      // Handle sign-in errors
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
