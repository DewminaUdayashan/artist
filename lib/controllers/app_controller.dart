import 'package:artist/helpers/firestore_helper.dart';
import 'package:artist/helpers/signin_helper.dart';
import 'package:artist/helpers/storage_helper.dart';
import 'package:artist/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  final PageController pageController = PageController();
  RxInt selectedPage = 0.obs;

  UserModel? tempUser;
  UserModel? currentUser;

  Future<void> signIn() async {
    UserCredential userCredential = await SignInHelper.signInWithGoogle();
    if (userCredential.user != null) {
      currentUser = UserModel(
        email: userCredential.user!.email,
        name: userCredential.user!.displayName,
        imageUrl: userCredential.user!.photoURL,
        mainPurpose: '1',
      );
      print(currentUser.toString());
      if (StorageHelper.isFirstTime()) {
        Get.offAllNamed('/setup');
      } else {
        FirestoreHelper.registerUser(currentUser!);
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
              tempUser = currentUser;
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
    FirestoreHelper.registerUser(currentUser!);
    Get.offAllNamed('/home');
  }

  @override
  void onInit() {
    super.onInit();
  }
}
