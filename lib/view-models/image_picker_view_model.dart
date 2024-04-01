import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/message_model.dart';
import '../views/chat-with-driver/on_image_select_view.dart';

class ImagePickerViewModel {
  showOptions(BuildContext context, MessageModel messageModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Image'),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            ElevatedButton(
              onPressed: () {
                _pickImageFromCamera(context, messageModel);
              },
              child: const Text('Camera'),
            ),
            ElevatedButton(
              onPressed: () {
                _pickImageFromGallery(context, messageModel);
              },
              child: const Text('Gallery'),
            ),
          ]),
        );
      },
    );
  }

  void _pickImageFromCamera(BuildContext context, MessageModel messageModel ) async {
    // Open the camera to capture an image
    final ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.camera).then((value) {
      if (value != null) {
        log("image path: ${value.path}");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OnImageSelectView(imageUrl: value.path, messageModel: messageModel)));
      } else {
        log("image is null");
        Navigator.pop(context);
      }
    });
  }

  void _pickImageFromGallery(BuildContext context, MessageModel messageModel) async {
    // Open the gallery to select an image
    final ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        log("image path: ${value.path}");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OnImageSelectView(imageUrl: value.path,  messageModel: messageModel)));
      } else {
        log("image is null");
        Navigator.pop(context);
      }
    });
  }
}
