import 'package:artist/controllers/app_controller.dart';
import 'package:artist/shared/instances.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({
    Key? key,
    this.isViewer = false,
  }) : super(key: key);

  final bool isViewer;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
        init: AppController(),
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.currentUser.value.bio ?? 'Add your bio here 😎',
                style: context.textTheme.headline3,
              ),
              if (isViewer) ...[],
            ],
          );
        });
  }
}
