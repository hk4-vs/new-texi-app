import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound_record/flutter_sound_record.dart';
import 'package:new_texi_app/models/message_model.dart';
import 'package:new_texi_app/models/my_variables.dart';

import '../../custom_widgets/display_image_from_firebase_storage_widget.dart';
import '../../view-models/chat_view_model.dart';
import '../../view-models/image_picker_view_model.dart';

class ChatWithDriverView extends StatefulWidget {
  final String userId;
  final String driverId;

  final String chatRoomId;
  final String bookingId;
  const ChatWithDriverView(
      {super.key,
      required this.userId,
      required this.driverId,
      required this.chatRoomId,
      required this.bookingId});

  @override
  State<ChatWithDriverView> createState() => _ChatWithDriverViewState();
}

class _ChatWithDriverViewState extends State<ChatWithDriverView> {
  TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final recoder = FlutterSoundRecord();
  @override
  Widget build(BuildContext context) {
    Color fillColor = Theme.of(context).disabledColor.withOpacity(0.1);

    log("userId: ${widget.userId}");
    log("driverId: ${widget.driverId}");
    log("chatroom id: ${widget.chatRoomId}");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat with driver"),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 12, top: 8),
        width: MyVariables.width(context),
        color: Colors.transparent,
        height: 50,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: Container()),
            GestureDetector(
              onTap: () {
                ImagePickerViewModel().showOptions(
                    context,
                    MessageModel(
                      chatRoomId: widget.chatRoomId,
                      senderId: widget.userId,
                      receiverId: widget.driverId,
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      dateTime: DateTime.now().toString(),
                      messageType: "image",
                    ));
              },
              child: CircleAvatar(
                backgroundColor: fillColor,
                radius: 24,
                child: Icon(
                  CupertinoIcons.camera_fill,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Container(
              width: MyVariables.width(context) * 0.65,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              child: TextField(
                keyboardType: TextInputType.text,
                controller: messageController,
                onTap: () {
                  _scrollToLastItem();
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: fillColor,
                  hintText: "Start typing...",
                  prefixIcon: Icon(
                    CupertinoIcons.mic_fill,
                    color: Theme.of(context).primaryColor,
                  ),
                  contentPadding: const EdgeInsets.only(left: 20, right: 20),
                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).disabledColor.withOpacity(0.4)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (messageController.text.trim().isNotEmpty) {
                  MessageModel messageModel = MessageModel(
                      senderId: widget.userId,
                      receiverId: widget.driverId,
                      message: messageController.text.trim(),
                      messageType: "text",
                      dateTime: DateTime.now().toString(),
                      chatRoomId: widget.chatRoomId,
                      id: DateTime.now().millisecondsSinceEpoch.toString());

                  ChatViewModel().sendMessage(messageModel: messageModel);
                  clear();
                }
              },
              child: CircleAvatar(
                backgroundColor: fillColor,
                radius: 24,
                child: Center(
                  child: Icon(
                    CupertinoIcons.paperplane_fill,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
      body: StreamBuilder(
          stream: MyVariables.firestore
              .collection("chatRoom")
              .doc(widget.chatRoomId)
              .collection("messages")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Something went wrong"),
              );
            }
            List<QueryDocumentSnapshot> docs =
                snapshot.data!.docs as List<QueryDocumentSnapshot>;
            List<MessageModel> messageList = docs
                .map((e) =>
                    MessageModel.fromMap(e.data() as Map<String, dynamic>))
                .toList();

            log("docs: $docs");
            log("messageList: $messageList");
            return Scrollbar(
              child: ListView.builder(
                  itemCount: messageList.length,
                  controller: _scrollController,
                  reverse: false,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    bool isMe = messageList[index].senderId == widget.userId;
                    String type = messageList[index].messageType.toString();
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: isMe
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(8),
                            margin: EdgeInsets.only(
                              left: isMe ? 80 : 10,
                              right: isMe ? 10 : 80,
                              bottom: 8.0,
                            ),
                            decoration: BoxDecoration(
                                color: fillColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: messageWidget(type, messageList[index])),
                      ],
                    );
                  }),
            );
          }),
    );
  }

 

  @override
  void dispose() {
    messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void clear() {
    messageController.clear();
    _scrollToLastItem();
  }

  void _scrollToLastItem() {
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  Widget messageWidget(String type, MessageModel messageModel) {
    switch (type) {
      case "text":
        return Text(messageModel.message.toString());
      case "image":
        return DisplayImageFromFirebaseStorageWidget(
          url: messageModel.imageUrl.toString(),
        );

      default:
        return Text(messageModel.message.toString());
    }
  }
}
