import 'dart:io';

import 'package:artist/controllers/create_post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostItem extends GetWidget<CreatePostController> {
  const PostItem({Key? key, required this.file, required this.index})
      : super(key: key);
  final File file;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.file(
              file,
              fit: BoxFit.fitHeight,
            ),
          ),
          Positioned(
            top: 5,
            left: 5,
            right: 5,
            child: Row(
              children: [
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black.withOpacity(.5),
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.crop,
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
              ],
            ),
          ),
          Positioned(
            right: 5,
            top: 5,
            child: InkWell(
              onTap: () {
                controller.removeMedia(index);
              },
              borderRadius: BorderRadius.circular(100),
              child: Ink(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(.5),
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
    );
  }
}
