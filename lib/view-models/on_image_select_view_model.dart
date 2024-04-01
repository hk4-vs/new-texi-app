import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_texi_app/models/message_model.dart';

import '../models/my_variables.dart';
import 'upload_file_to_firebase_storage.dart';

class OnImageSelectViewModel with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  setIsloading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  sendImage(
      {required MessageModel messageModel,
      required BuildContext context,
      required String imageUrl}) {
    setIsloading(true);
    log("UploadFileToFirebaseStorage start");
    UploadFileToFirebaseStorage()
        .uploadImageToFirebase(File(imageUrl))
        .then((value) {
      log("UploadFileToFirebaseStorage than");
      messageModel.imageUrl = value;
      log("ChatViewModel start");
      MyVariables.firestore
          .collection("chatRoom")
          .doc(messageModel.chatRoomId)
          .collection("messages")
          .doc(messageModel.id)
          .set(messageModel.toMap())
          .then((value) {
        log("ChatViewModel than");
        Navigator.pop(context);
        Navigator.pop(context);
      });
    });

    setIsloading(false);
  }
}
