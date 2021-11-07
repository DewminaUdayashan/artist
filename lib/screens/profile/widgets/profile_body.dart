import 'package:artist/controllers/app_controller.dart';
import 'package:artist/models/user_model.dart';
import 'package:artist/shared/instances.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({
    Key? key,
    this.user,
  }) : super(key: key);

  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
        init: AppController(),
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user != null
                    ? user!.bio ?? 'No bio'
                    : controller.currentUser.value.bio ??
                        'Add your bio here 😎',
                style: context.textTheme.headline3,
              ),
              if (user != null) ...[],
            ],
          );
        });
  }
}
