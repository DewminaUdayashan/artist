import 'dart:io';

import 'package:artist/shared/instances.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uuid/uuid.dart';

class FirebaseStorageHelper {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  static Future<void> uploadFile(File file) async {
    try {
      firebase_storage.UploadTask task = firebase_storage
          .FirebaseStorage.instance
          .ref(
              'uploads/user_profiles/${appController.currentUser!.id ?? const Uuid().v4()}')
          .putFile(file);
      task.snapshotEvents.listen(
        (firebase_storage.TaskSnapshot snapshot) async {
          // print('Task state: ${snapshot.state}');
          // print(
          //     'Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100} %');
          appController.currentUser!.imageUrl =
              await snapshot.ref.getDownloadURL();
          print(await snapshot.ref.getDownloadURL());
        },
        onError: (err) {
          print(err);
        },
      );
    } catch (e) {
      // e.g, e.code == 'canceled'
      print(e.toString());
    }
  }
}
