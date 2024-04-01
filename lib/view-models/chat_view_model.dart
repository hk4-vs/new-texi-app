import 'dart:developer';
import 'package:flutter_sound_record/flutter_sound_record.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/material.dart';
import 'package:new_texi_app/models/chat_room_model.dart';
import 'package:new_texi_app/models/message_model.dart';
import 'package:new_texi_app/models/my_variables.dart';
import 'package:new_texi_app/views/chat-with-driver/chat_with_driver_view.dart';

class ChatViewModel {
  final recoder = FlutterSoundRecord();
  createChatRoom(
      {required String userId,
      required String driverId,
      required String bookingId,
      required BuildContext context}) async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    MyVariables.firestore
        .collection("chatRoom")
        .doc(id)
        .set(ChatRoomMode(
                id: id,
                userId: userId,
                driverId: driverId,
                bookingId: bookingId)
            .toMap())
        .then((value) {
      log("Chat Room Created");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatWithDriverView(
                  userId: userId,
                  driverId: driverId,
                  chatRoomId: id,
                  bookingId: bookingId)));
    });
  }

  checkChatRoomisExist(
      {required String userId,
      required String driverId,
      required String bookingId,
      required BuildContext context}) {
    MyVariables.firestore
        .collection("chatRoom")
        .where("bookingId", isEqualTo: bookingId)
        .limit(1)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        log("Chat Room Not Exist");
        createChatRoom(
            userId: userId,
            driverId: driverId,
            context: context,
            bookingId: bookingId);
      } else {
        log("Chat Room Exist");
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatWithDriverView(
                  userId: userId,
                  driverId: driverId,
                  chatRoomId: value.docs.first.id.toString(),
                  bookingId: bookingId)),
        );
      }
    });
  }

  sendMessage({required MessageModel messageModel}) {
    MyVariables.firestore
        .collection("chatRoom")
        .doc(messageModel.chatRoomId)
        .collection("messages")
        .doc(messageModel.id)
        .set(messageModel.toMap());
  }

  initVoiceRecording() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw "Microphone permission not granted";
    }
  }

  startVoiceRecording()async {
   await recoder.start();
   
  }
  stopVoiceRecording()async {
   await recoder.stop();
  }
  pauseVoiceRecording()async {
   await recoder.pause();
  }
  
}
