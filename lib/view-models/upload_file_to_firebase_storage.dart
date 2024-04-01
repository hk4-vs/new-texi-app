import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';


class UploadFileToFirebaseStorage {
  Future<String> uploadImageToFirebase(File imageFile) async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageReference = storage.ref().child('images/$id.png');
    UploadTask uploadTask = storageReference.putFile(imageFile);

    TaskSnapshot taskSnapshot = await uploadTask;
  
    log("full path: ${taskSnapshot.ref.fullPath}");

    return taskSnapshot.ref.fullPath;
  }
}
