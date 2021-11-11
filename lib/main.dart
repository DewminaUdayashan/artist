import 'dart:async';

import 'package:artist/bindings/create_post_binding.dart';
import 'package:artist/bindings/edit_account_bindings.dart';
import 'package:artist/screens/create_post/create_post.dart';
import 'package:artist/screens/home/home.dart';
import 'package:artist/screens/profile/edit_account.dart';
import 'package:artist/screens/signin/register.dart';
import 'package:artist/screens/signin/signin.dart';
import 'package:artist/bindings/bindings.dart';
import 'package:artist/screens/signin/widgets/verification.dart';
import 'package:artist/screens/splash/splash.dart';
import 'package:artist/shared/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'screens/signin/setup_account.dart';
import 'screens/splash/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runZonedGuarded<Future<void>>(() async {
    runApp(
      const MyApp(),
    );
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.testMode = true; //todo
    return GetMaterialApp(
      title: 'Artist',
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
            name: '/splash',
            page: () => const Splash(),
            binding: InitialBindings()),
        GetPage(name: '/home', page: () => const Home()),
        GetPage(name: '/signIn', page: () => const Signin()),
        GetPage(name: '/setup', page: () => const SetupAccount()),
        GetPage(
          name: '/editAccount',
          page: () => const EditAccount(),
          binding: EditAccountBindings(),
        ),
        GetPage(
          name: '/createPost',
          page: () => const CreatePost(),
          transition: Transition.cupertinoDialog,
          binding: CreatePostBinding(),
        ),
        GetPage(
          name: '/register',
          page: () => const Register(),
        ),
        GetPage(
          name: '/verification',
          page: () => const Verification(),
        ),
      ],
      theme: lightThemeData,
      initialRoute: '/splash',
    );
  }
}
//
