import 'dart:io';

import 'package:artist/helpers/firebase_storage_helper.dart';
import 'package:artist/helpers/firestore_helper.dart';
import 'package:artist/helpers/signin_helper.dart';
import 'package:artist/helpers/storage_helper.dart';
import 'package:artist/models/post_model.dart';
import 'package:artist/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'create_post_controller.dart';

class AppController extends GetxController {
  final PageController pageController = PageController();
  RxInt selectedPage = 0.obs;

  UserModel? tempUser;
  Rx<UserModel> currentUser = UserModel().obs;

  int postLimit = 10;
  bool hasNextCurrentUserPost = true;
  bool hasNextFeedPost = true;
  RxBool isCurrentUserPostFetcing = false.obs;
  RxBool isFeedPostFetching = false.obs;
  RxList<QueryDocumentSnapshot<Object?>> currentUserPosts =
      List<QueryDocumentSnapshot>.empty(growable: true).obs;
  RxList<QueryDocumentSnapshot<Object?>> feedPosts =
      List<QueryDocumentSnapshot>.empty(growable: true).obs;
  ScrollController profileScrollController = ScrollController();
  ScrollController feedScrollController = ScrollController();

  Future<void> fetchNextCurrentUserPost() async {
    if (isCurrentUserPostFetcing.value) return;
    isCurrentUserPostFetcing.value = true;
    try {
      final snap = await FirestoreHelper.getUserPosts(
        postLimit,
        startAfter: currentUserPosts.isNotEmpty ? currentUserPosts.last : null,
      );

      for (var doc in snap.docs) {
        currentUserPosts.add(doc);
      }

      if (snap.docs.length < postLimit) hasNextCurrentUserPost = false;
      // currentUserPosts.addAll(snap.docs);
    } catch (e) {
      print(e);
    }
    isCurrentUserPostFetcing.value = false;
  }

  Future<void> fetchNextFeedPosts() async {
    if (isFeedPostFetching.value) return;
    isFeedPostFetching.value = true;
    try {
      final snap = await FirestoreHelper.getFeedPosts(
        postLimit,
        startAfter: feedPosts.isNotEmpty ? feedPosts.last : null,
      );
      for (var doc in snap.docs) {
        feedPosts.add(doc);
      }
      if (snap.docs.length < postLimit) hasNextFeedPost = false;
    } catch (e) {
      print(e);
    }
    isFeedPostFetching.value = false;
  }

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
      await signIn();
    } else {
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
  List<PickedMedia> files = List<PickedMedia>.empty(growable: true);

  void handlePost() {
    FirebaseStorageHelper.uploadPost(files.map((e) => e.file).toList());
    currentPost.date = DateTime.now().toString();
    currentPost.mediaUrls = List<String>.empty(growable: true);
  }

  Future<void> addPostDetails() async {
    FirestoreHelper.addPost();
    currentUserPosts.clear();
    fetchNextCurrentUserPost();
  }

  void profileScrollListner() {
    if (profileScrollController.offset >=
            profileScrollController.position.maxScrollExtent &&
        !profileScrollController.position.outOfRange) {
      print('on bottom');
      print(hasNextCurrentUserPost);
      if (hasNextCurrentUserPost) {
        fetchNextCurrentUserPost();
      }
    }
  }

  void feedScrollListner() {
    if (feedScrollController.offset >=
            feedScrollController.position.maxScrollExtent &&
        !feedScrollController.position.outOfRange) {
      print('on bottom');
      print(hasNextFeedPost);
      if (hasNextFeedPost) {
        fetchNextFeedPosts();
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    feedScrollController.addListener(feedScrollListner);
    profileScrollController.addListener(profileScrollListner);
    fetchNextFeedPosts();
    fetchNextCurrentUserPost();
  }

  @override
  void onClose() {
    feedScrollController.removeListener(feedScrollListner);
    feedScrollController.dispose();
    profileScrollController.removeListener(profileScrollListner);
    profileScrollController.dispose();

    super.onClose();
  }
}
