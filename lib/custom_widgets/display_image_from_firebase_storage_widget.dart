import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class DisplayImageFromFirebaseStorageWidget extends StatelessWidget {
  const DisplayImageFromFirebaseStorageWidget({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: FirebaseStorage.instance.ref(url).getDownloadURL(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Image.network(snapshot.data!);
        }
      },
    );
  }
}
