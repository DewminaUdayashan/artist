import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:artist/controllers/app_controller.dart';
import 'package:artist/models/user_model.dart';
import 'package:artist/shared/instances.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileTop extends GetWidget<AppController> {
  const ProfileTop({
    Key? key,
    this.user,
  }) : super(key: key);
  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
      child: SizedBox(
        height: Get.height / 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Text(
              'Welcome!',
              style: GoogleFonts.ubuntu(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            GetBuilder<AppController>(
                init: AppController(),
                builder: (controller) {
                  return Text(
                    user != null
                        ? user!.name!
                        : controller.currentUser.value.name!,
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }),
            DefaultTextStyle(
              style: GoogleFonts.ubuntu(
                color: Colors.white,
                fontSize: 18,
              ),
              child: AnimatedTextKit(
                repeatForever: true,
                isRepeatingAnimation: true,
                displayFullTextOnTap: true,
                animatedTexts: [
                  if (appController.currentUser.value.categorieIds == null) ...[
                    TypewriterAnimatedText(
                      'No details to show',
                      speed: const Duration(milliseconds: 100),
                    ),
                  ],
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
