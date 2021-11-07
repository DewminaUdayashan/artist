import 'package:artist/controllers/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';

class ProfilePicture extends GetWidget<AppController> {
  const ProfilePicture({
    Key? key,
  }) : super(key: key);

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
                return OctoImage(
                  image: NetworkImage(controller.currentUser.value.imageUrl!),
                  placeholderBuilder: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorBuilder: (context, error, stackTrace) =>
                      const Text('Unable to load'), //TODO
                  fit: BoxFit.cover,
                );
              }),
        ),
      ),
    );
  }
}
