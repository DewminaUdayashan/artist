import 'dart:async';

import 'package:artist/screens/home/home.dart';
import 'package:artist/screens/signin/signin.dart';
import 'package:artist/shared/bindings.dart';
import 'package:artist/shared/themes.dart';
import 'package:artist/splash/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      ],
      theme: lightThemeData,
      initialRoute: '/splash',
    );
  }
}
