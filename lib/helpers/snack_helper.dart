import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackHelper {
  static void nameEmpty() {
    Get.rawSnackbar(
      backgroundColor: Colors.amber,
      icon: const Icon(Icons.warning),
      title: 'Name must not be empty',
      message: 'Please enter your name',
      snackPosition: SnackPosition.TOP,
    );
  }

  static void alradyVideoAdded() {
    Get.rawSnackbar(
      backgroundColor: Colors.amber,
      icon: const Icon(Icons.warning),
      title: 'Video already added',
      message: 'There should be only one video to the your post',
      snackPosition: SnackPosition.TOP,
    );
  }
}
