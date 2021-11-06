import 'package:artist/controllers/app_controller.dart';
import 'package:artist/screens/profile/widgets/profile_body.dart';
import 'package:artist/screens/profile/widgets/profile_picture.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/animated_bg.dart';
import 'widgets/profile_top.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, this.isViewer = true}) : super(key: key);

  final bool isViewer;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with TickerProviderStateMixin {
  AppController controller = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: Get.height / 1.5,
            width: Get.width,
            color: const Color(0xff35B7F1),
          ),
          const AnimatedBg(),
          const ProfileTop(),
          SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: Get.height / 2.2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.crop_square_rounded,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                const Spacer(),
                                Text(
                                  'My Profile',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 25,
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  icon: const Icon(
                                    Icons.more_vert_outlined,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  onPressed: () => controller.openAppSettings(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: Get.height * 2,
                      width: Get.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 70,
                        horizontal: 16,
                      ),
                      child: const ProfileBody(
                        isViewer: true,
                      ),
                    ),
                  ],
                ),
                const ProfilePicture(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
