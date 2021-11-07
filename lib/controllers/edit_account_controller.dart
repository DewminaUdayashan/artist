import 'dart:io';

import 'package:artist/helpers/firebase_storage_helper.dart';
import 'package:artist/helpers/firestore_helper.dart';
import 'package:artist/helpers/snack_helper.dart';
import 'package:artist/shared/instances.dart';
import 'package:flutter/cupertino.dart';
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
  final dobController = TextEditingController();
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
    update();
  }

  Future<void> saveChanges() async {
    isSaving = true;
    update();
    if (file != null) {
      await FirebaseStorageHelper.uploadFile(file!);
    }
    if (nameController.text == '' || nameController.text.isEmpty) {
      SnackHelper.nameEmpty();
    } else if (nameController.text != appController.currentUser.value.name) {
      appController.currentUser.value.name = nameController.text;
    }

    if (bioController.text.isNotEmpty) {
      if (bioController.text != appController.currentUser.value.bio) {
        appController.currentUser.value.bio = bioController.text;
      }
    }

    if (mobileController.text.isNotEmpty) {
      if (mobileController.text != appController.currentUser.value.mobile) {
        appController.currentUser.value.mobile = mobileController.text;
      }
    }

    if (mobileController.text != appController.currentUser.value.birthdate) {
      appController.currentUser.value.birthdate = mobileController.text;
    }

    await FirestoreHelper.updatedUser(appController.currentUser.value);
    appController.update();
    Get.back();
    Get.back();
    isSaving = false;
    update();
  }

  void showDatePicker(ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 500,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height / 2,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: DateTime.now(),
                      onDateTimeChanged: (val) {
                        dobController.text = val.toString().split(' ')[0];
                        update();
                      },
                    ),
                  ),

                  // Close the modal
                  CupertinoButton(
                    child: const Text('OK'),
                    onPressed: () => Navigator.of(ctx).pop(),
                  )
                ],
              ),
            ));
  }

  @override
  void onInit() {
    super.onInit();
    nameController.text = appController.currentUser.value.name ?? '';
    bioController.text = appController.currentUser.value.bio ?? '';
    mobileController.text = appController.currentUser.value.mobile ?? '';
    dobController.text = appController.currentUser.value.birthdate ?? '';
    print(appController.currentUser.value.name);
    update();
  }
}
