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

  static void somethingWentWrong(String err) {
    Get.rawSnackbar(
      backgroundColor: Colors.redAccent,
      icon: const Icon(Icons.warning),
      title: 'Something went wrong',
      message: err,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 5),
    );
  }

  static void loginError(String err) {
    Get.rawSnackbar(
        backgroundColor: Colors.redAccent,
        icon: const Icon(Icons.warning),
        title: 'Login error',
        message: err,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 5));
  }

  static void enterName() {
    Get.rawSnackbar(
        backgroundColor: Colors.redAccent,
        icon: const Icon(Icons.warning),
        title: 'Error',
        message: 'Please enter your name',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 5));
  }

  static void enteEmail() {
    Get.rawSnackbar(
        backgroundColor: Colors.redAccent,
        icon: const Icon(Icons.warning),
        title: 'Error',
        message: 'Please enter valid email',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 5));
  }

  static void passwordNotStrength() {
    Get.rawSnackbar(
        backgroundColor: Colors.redAccent,
        icon: const Icon(Icons.warning),
        title: 'Error',
        message: 'Please enter strong password',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 5));
  }

  static void passwordMismatch() {
    Get.rawSnackbar(
      backgroundColor: Colors.redAccent,
      icon: const Icon(Icons.warning),
      title: 'Password not matching',
      message: 'Please re enter your password',
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 5),
    );
  }
}
