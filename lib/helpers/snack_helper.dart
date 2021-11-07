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
}
