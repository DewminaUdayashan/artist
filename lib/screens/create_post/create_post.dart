import 'package:artist/controllers/create_post_controller.dart';
import 'package:artist/shared/instances.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';

class CreatePost extends GetWidget<CreatePostController> {
  const CreatePost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            splashRadius: 20,
            tooltip: 'Post',
            icon: const Icon(
              Icons.send,
              color: Colors.black54,
            ),
            onPressed: () {
              controller.makePost();
            },
          ),
        ],
        leading: IconButton(
          splashRadius: 20,
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black54,
          ),
        ),
        leadingWidth: 40,
        title: Text('Create Post', style: context.textTheme.headline2),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Obx(
                () => controller.videoProcessing.value
                    ? const LinearProgressIndicator(
                        backgroundColor: Colors.white,
                      )
                    : const SizedBox.shrink(),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    OctoImage(
                      height: 50,
                      width: 50,
                      image: NetworkImage(
                        appController.currentUser.value.imageUrl!,
                      ),
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(
                            Icons.error,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 15),
                    Text(
                      appController.currentUser.value.name!,
                      style: context.textTheme.bodyText1,
                    ),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: () => controller.addMedia(),
                      icon: const Icon(Icons.add_a_photo_rounded),
                      label: const Text('Media'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: "What's in your mind..",
                    border: InputBorder.none,
                  ),
                  style: context.textTheme.bodyText1,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  onChanged: (value) => controller.description = value,
                ),
              ),
              const SizedBox(height: 15),
              GetBuilder<CreatePostController>(
                  init: CreatePostController(),
                  builder: (context) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.pickedFiles.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Stack(
                            children: [
                              Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Image.file(
                                      controller.pickedFiles[index].isVideo
                                          ? controller.pickedFiles[index].thumb!
                                          : controller.pickedFiles[index].file!,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                  if (controller
                                      .pickedFiles[index].isVideo) ...[
                                    Obx(
                                      () => Positioned(
                                        top: 0,
                                        right: 0,
                                        left: 0,
                                        bottom: 0,
                                        child: !controller.videoProcessing.value
                                            ? const Icon(
                                                Icons.play_circle_fill_rounded,
                                                color: Colors.black,
                                                size: 50,
                                              )
                                            : Text(
                                                'Video processing : ${controller.compressProgress.toStringAsFixed(2)}%',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  backgroundColor: Colors.white,
                                                  fontSize: 18,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              Positioned(
                                top: 5,
                                left: 5,
                                right: 5,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    if (!controller.pickedFiles[index].isVideo)
                                      TextButton(
                                        onPressed: () =>
                                            controller.cropImage(index),
                                        style: TextButton.styleFrom(
                                          backgroundColor:
                                              Colors.black.withOpacity(.5),
                                        ),
                                        child: Row(
                                          children: const [
                                            Icon(
                                              CupertinoIcons.crop_rotate,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            SizedBox(width: 6),
                                            Text(
                                              'Crop',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    const Spacer(),
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          controller.removeMedia(index);
                                        },
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Ink(
                                          padding: const EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(.5),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
