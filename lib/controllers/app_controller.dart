import 'dart:io';

import 'package:artist/helpers/firebase_storage_helper.dart';
import 'package:artist/helpers/firestore_helper.dart';
import 'package:artist/helpers/signin_helper.dart';
import 'package:artist/helpers/storage_helper.dart';
import 'package:artist/models/post_model.dart';
import 'package:artist/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'create_post_controller.dart';

class AppController extends GetxController {
  final PageController pageController = PageController();
  RxInt selectedPage = 0.obs;

  UserModel? tempUser;
  Rx<UserModel> currentUser = UserModel().obs;

  Future<void> signIn() async {
    UserCredential userCredential = await SignInHelper.signInWithGoogle();
    if (userCredential.user != null) {
      currentUser.value.email = userCredential.user!.email;
      currentUser.value.name = userCredential.user!.displayName;
      currentUser.value.imageUrl = userCredential.user!.photoURL;
      currentUser.value.mainPurpose = '1';
      currentUser.value.joinedDate = DateTime.now().toString();
      print(currentUser.toString());
      if (StorageHelper.isFirstTime()) {
        Get.offAllNamed('/setup');
      } else {
        FirestoreHelper.registerUser(currentUser.value);
        Get.offAllNamed('/home');
      }
    } else {
      //TODO:
    }
  }

  void onTabTapped(int page) {
    selectedPage.value = page;

    pageController.animateToPage(
      page,
      duration: const Duration(
        milliseconds: 300,
      ),
      curve: Curves.ease,
    );
  }

  void onPageChanged(int page) {
    selectedPage.value = page;
  }

  void openAppSettings() {
    print('tapped');
    showCupertinoModalPopup(
      context: Get.context!,
      builder: (context) => CupertinoActionSheet(
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () {},
          child: const Text(
            'Cancel',
          ),
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              tempUser = currentUser.value;
              Get.toNamed('/editAccount');
            },
            child: const Text(
              'Edit Account',
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {},
            child: const Text(
              'Settings',
            ),
          ),
        ],
      ),
    );
  }

  void handleSignIn() async {
    if (!StorageHelper.isFirstTime()) {
      print('not first Time');
      await signIn();
    } else {
      print(' first Time');

      Get.offAllNamed('/signIn');
    }
  }

  void markAppOpened() {
    StorageHelper.markFirstTime();
    FirestoreHelper.registerUser(currentUser.value);
    Get.offAllNamed('/home');
  }

  PostModel currentPost = PostModel();
  RxString bytesTrassferd = ''.obs;
  void handlePost(List<PickedMedia> files, String description) {
    FirebaseStorageHelper.uploadPost(files.map((e) => e.file).toList());
    currentPost.date = DateTime.now().toString();
    currentPost.description = description;
    currentPost.mediaUrls = List<String>.empty(growable: true);
  }

  @override
  void onInit() {
    super.onInit();
  }
}
