import 'dart:io';

import 'package:artist/helpers/snack_helper.dart';
import 'package:artist/screens/create_post/widgets/trimmer_view.dart';
import 'package:artist/shared/instances.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class CreatePostController extends GetxController {
  Subscription? _subscription;
  final ImagePicker _picker = ImagePicker();
  RxDouble compressProgress = 0.0.obs;
  RxBool videoProcessing = false.obs;
  RxList<PickedMedia> pickedFiles = List<PickedMedia>.empty(growable: true).obs;

  Future<void> makePost() async {
    appController.handlePost(pickedFiles.toList(), 'desc');
  }

  void addMedia() {
    showCupertinoModalPopup(
      context: Get.context!,
      builder: (context) => CupertinoActionSheet(
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () => Get.back(),
          child: const Text(
            'Cancel',
          ),
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              pickImage();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(
                  CupertinoIcons.photo,
                  color: Colors.blue,
                ),
                SizedBox(width: 10),
                Text(
                  'Image',
                ),
              ],
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              pickVideo();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(
                  Icons.video_camera_back,
                  color: Colors.blue,
                ),
                SizedBox(width: 10),
                Text(
                  'Video',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> pickImage() async {
    _picker.pickMultiImage().then((files) {
      if (files != null) {
        for (XFile file in files) {
          pickedFiles.add(PickedMedia(isVideo: false, file: File(file.path)));
        }
        update();
      }
    });

    Get.back();
  }

  Future<void> pickVideo() async {
    if (pickedFiles.where((p) => p.isVideo).isNotEmpty) {
      Get.back();
      SnackHelper.alradyVideoAdded();
    } else {
      _picker
          .pickVideo(
        source: ImageSource.gallery,
        maxDuration: const Duration(seconds: 30),
      )
          .then((file) async {
        if (file != null) {
          compressVideo(file.path);
          update();
        }
      });
      Get.back();
    }
  }

  int videoFileIndex = 0;
  Future<void> compressVideo(String path) async {
    compressProgress.value = 0;
    videoProcessing.value = true;
    update();

    createThumbnail(path);
    MediaInfo? mediaInfo = await VideoCompress.compressVideo(
      path,
      duration: const Duration(minutes: 1).inSeconds,
      quality: VideoQuality.MediumQuality,
    );

    if (mediaInfo != null) {
      if (mediaInfo.file != null) {
        pickedFiles[videoFileIndex].file = mediaInfo.file!;
      }
    }
    videoProcessing.value = false;
    update();
  }

  Future<void> createThumbnail(String path) async {
    final thumbnailFile = await VideoCompress.getFileThumbnail(path,
        quality: 50, // default(100)
        position: -1 // default(-1)
        );
    pickedFiles.add(PickedMedia(isVideo: true, thumb: thumbnailFile));
    videoFileIndex = pickedFiles.length - 1;
    update();
  }

  Future<void> cropImage(int index) async {
    File? file = await ImageCropper.cropImage(
      sourcePath: pickedFiles[index].file!.path,
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Get.context!.theme.primaryColor,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: true,
      ),
      iosUiSettings: const IOSUiSettings(
        minimumAspectRatio: 1.0,
      ),
    );
    if (file != null) {
      pickedFiles.removeAt(index);
      pickedFiles.insert(
        index,
        PickedMedia(
          isVideo: false,
          file: file,
        ),
      );
      update();
    }
  }

  void removeMedia(int index) {
    if (pickedFiles[index].isVideo && VideoCompress.isCompressing) {
      VideoCompress.cancelCompression();
    }
    pickedFiles.removeAt(index);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    _subscription = VideoCompress.compressProgress$.subscribe((progress) {
      debugPrint('progress: $progress');
      compressProgress.value = progress;
    });
  }

  @override
  void onClose() {
    if (_subscription != null) _subscription!.unsubscribe();

    super.onClose();
  }
}

class PickedMedia {
  File? file;
  File? thumb;
  bool isVideo;
  PickedMedia({
    required this.isVideo,
    this.file,
    this.thumb,
  });
}
