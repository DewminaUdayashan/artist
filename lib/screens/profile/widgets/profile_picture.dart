import 'package:artist/controllers/app_controller.dart';
import 'package:artist/models/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';

class ProfilePicture extends GetWidget<AppController> {
  const ProfilePicture({
    Key? key,
    this.user,
  }) : super(key: key);

  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: Get.height / 2.7,
      left: 30,
      child: Container(
        height: 120,
        width: 120,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: GetBuilder<AppController>(
              init: AppController(),
              builder: (context) {
                return CachedNetworkImage(
                  imageUrl: user != null
                      ? user!.imageUrl!
                      : controller.currentUser.value.imageUrl!,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Center(
                    child: Text('something\nwent\wrong'),
                  ),
                  fit: BoxFit.cover,
                );
              }),
        ),
      ),
    );
  }
}
