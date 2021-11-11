import 'dart:async';
import 'dart:io';

import 'package:artist/api/api_provider.dart';
import 'package:artist/helpers/firebase_storage_helper.dart';
import 'package:artist/helpers/firestore_helper.dart';
import 'package:artist/helpers/signin_helper.dart';
import 'package:artist/helpers/storage_helper.dart';
import 'package:artist/models/post_model.dart';
import 'package:artist/models/user_model.dart';
import 'package:artist/shared/instances.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'create_post_controller.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class AppController extends GetxController {
  String loginEmail = '';
  String loginPw = '';
  String sessionToken = '';
  final ApiProvider api = ApiProvider();
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
    // SignInHelper.signInWithGoogle();
    print('===========================');
    SignInHelper.signInwithPassword();
    // // try {

    //   UserCredential userCredential = await SignInHelper.signInWithGoogle();
    //   if (userCredential.user != null) {
    //     currentUser.value.email = userCredential.user!.email;
    //     currentUser.value.name = userCredential.user!.displayName;
    //     currentUser.value.imageUrl = userCredential.user!.photoURL;
    //     currentUser.value.mainPurpose = '0';
    //     currentUser.value.joinedDate = DateTime.now().toString();
    //     if (StorageHelper.isFirstTime()) {
    //       Get.offAllNamed('/setup');
    //     } else {
    //       markAppOpened();
    //     }
    //   } else {
    //     //TODO:
    //   }
    // } catch (e) {
    //   //TODO:
    // }
  }

  void checkEmail() {
    SignInHelper.checkEmail();
  }

  Future<void> continueWithGoogle() async {}

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
    // FirestoreHelper.registerUser(currentUser.value);
    api.registerUser(appController.currentUser.value);
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


    // IO.Socket socket = IO.io(
    //   'ws://192.168.34.2:5000',
    //   OptionBuilder()
    //       .setTransports(['websocket']) // for Flutter or Dart VM
    //       .disableAutoConnect()
    //       .build(),
    // );
    // socket.onConnect((_) {
    //   print('connect');
    //   socket.emit('msg', 'test');
    // });
    // socket.on('event', (data) => print(data));
    // socket.onDisconnect((_) => print('disconnect'));
    // socket.on('fromServer', (_) => print(_));
    // socket.onConnect((data) => print('data'));
    // socket.onError((data) => print(data));
    // socket.onConnectError((data) => print(data));

    // socket.on('connect_error', (data) => print(data));
    // socket.on('connect_timeout', (data) => print(data));
    // socket.on('connecting', (data) => print(data));
    // socket.on('disconnect', (data) => print(data));
    // socket.on('error', (data) => print(data));
    // socket.on('reconnect', (data) => print(data));
    // socket.on('reconnect_attempt', (data) => print(data));
    // socket.on('reconnect_failed', (_) => print(_));
    // socket.on('reconnect_error', (_) => print(_));

    // socket.on('reconnecting', (_) => print(_));
    // socket.on('ping', (_) => print(_));
    // socket.on('pong', (_) => print(_));
    // socket.connect();