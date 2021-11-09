import 'dart:io';

import 'package:artist/shared/instances.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import 'firestore_helper.dart';

class FirebaseStorageHelper {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  static Future<void> uploadFile(File file) async {
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
      appController.currentUser.value.imageUrl = uri;
      FirestoreHelper.updatedUserImageUrl(uri);
    });
  }

  static Future<void> uploadPost(List<File?> files) async {
    Get.rawSnackbar(
      title: 'Posting..',
      message: 'Your post is being uploading..',
      backgroundColor: Colors.green[800]!,
      isDismissible: false,
      duration: const Duration(days: 1),
      shouldIconPulse: true,
      icon: const Icon(
        Icons.file_upload,
        color: Colors.white,
      ),
      showProgressIndicator: true,
      progressIndicatorBackgroundColor: Colors.green[800],
      progressIndicatorValueColor:
          const AlwaysStoppedAnimation<Color>(Colors.white),
      snackPosition: SnackPosition.TOP,
    );
    String coll = DateTime.now().toString();
    for (File? file in files) {
      firebase_storage.Reference reference = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('uploads')
          .child('/posts')
          .child(appController.currentUser.value.id!)
          .child(coll)
          .child('${const Uuid().v4()}.${file!.path.split('.').last}');
      firebase_storage.UploadTask task = reference.putFile(file);
      task.snapshotEvents.listen((snapshot) {
        appController.bytesTrassferd.value =
            ((snapshot.bytesTransferred / snapshot.totalBytes) * 100)
                .toString();
        print(appController.bytesTrassferd.value);
      });
      firebase_storage.TaskSnapshot snapshot =
          await task.whenComplete(() => null);
      String uri = await snapshot.ref.getDownloadURL();
      appController.currentPost.mediaUrls!.add(uri);
      print('===============================' + uri);
    }
    appController.addPostDetails();
    if (Get.isSnackbarOpen ?? false) {
      Get.back();
    }
    print('///////////////////////////////done');
  }
}
