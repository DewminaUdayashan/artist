import 'package:artist/controllers/app_controller.dart';
import 'package:artist/helpers/firestore_helper.dart';
import 'package:artist/models/post_model.dart';
import 'package:artist/models/user_model.dart';
import 'package:artist/screens/create_post/widgets/post_item.dart';
import 'package:artist/screens/home_page/widgets/post_item.dart';
import 'package:artist/shared/instances.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  user != null
                      ? user!.bio ?? 'No bio'
                      : controller.currentUser.value.bio ??
                          'Add your bio here 😎',
                  style: context.textTheme.headline3,
                ),
              ),
              const SizedBox(height: 10),
              const Divider(thickness: 10),
              if (user == null) ...[
                Obx(
                  () => ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: appController.userPosts.length,
                    itemBuilder: (context, index) {
                      final post =
                          appController.userPosts[index].data() as PostModel;
                      final postId = appController.userPosts[index].id;
                      return UserPostItem(post: post, id: postId);
                    },
                    separatorBuilder: (context, index) =>
                        const Divider(thickness: 10),
                  ),
                ),
                const SizedBox(height: 20),
                Obx(
                  () => appController.isFetching.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ],
          );
        });
  }
}
