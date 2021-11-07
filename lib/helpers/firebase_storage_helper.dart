import 'dart:io';

import 'package:artist/shared/instances.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uuid/uuid.dart';

import 'firestore_helper.dart';

class FirebaseStorageHelper {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  static Future<void> uploadFile(File file) async {
    String _url = appController.currentUser.value.imageUrl ?? '';
    firebase_storage.Reference reference = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('uploads')
        .child('/user_profiles')
        .child(
            '/${appController.currentUser.value.id ?? const Uuid().v4()}.${file.path.split('.').last}');
    firebase_storage.UploadTask task = reference.putFile(file);
    firebase_storage.TaskSnapshot snapshot =
        await task.whenComplete(() => null);
    snapshot.ref.getDownloadURL().then((uri) {
      print('url ==========================================================');
      _url = uri;
      appController.currentUser.value.imageUrl = uri;
      FirestoreHelper.updatedUserImageUrl(uri);
    });
  }
}
