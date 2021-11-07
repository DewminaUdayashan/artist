import 'dart:io';

import 'package:artist/helpers/firebase_storage_helper.dart';
import 'package:artist/helpers/snack_helper.dart';
import 'package:artist/shared/instances.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class EditAccountController extends GetxController {
  bool isSaving = false;
  final nameController = TextEditingController();
  final bioController = TextEditingController();
  final mobileController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? file;

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      file = await ImageCropper.cropImage(
        sourcePath: image.path,
        compressQuality: 50,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Get.context!.theme.primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
        iosUiSettings: const IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      );
      update();
    }
  }

  Future<void> saveChanges() async {
    isSaving = true;
    update();
    if (file != null) {
      await FirebaseStorageHelper.uploadFile(file!);
    }
    if (nameController.text == '' || nameController.text.isEmpty) {
      SnackHelper.nameEmpty();
    } else if (nameController.text != appController.currentUser!.name) {
      appController.currentUser!.name = nameController.text;
    }

    if (bioController.text.isNotEmpty) {
      if (bioController.text != appController.currentUser!.bio) {
        appController.currentUser!.bio = bioController.text;
      }
    }

    if (mobileController.text.isNotEmpty) {
      if (mobileController.text != appController.currentUser!.mobile) {
        appController.currentUser!.mobile = mobileController.text;
      }
    }

    print(appController.currentUser.toString());

    isSaving = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    nameController.text = appController.currentUser!.name ?? '';
    bioController.text = appController.currentUser!.bio ?? '';
    mobileController.text = appController.currentUser!.mobile ?? '';
    print(appController.currentUser!.name);
    update();
  }
}
