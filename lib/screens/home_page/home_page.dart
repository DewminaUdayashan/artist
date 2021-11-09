import 'package:artist/models/post_model.dart';
import 'package:artist/screens/create_post/create_post.dart';
import 'package:artist/screens/home_page/widgets/search_bar.dart';
import 'package:artist/screens/home_page/widgets/top_bar.dart';
import 'package:artist/screens/home_page/widgets/top_carousel.dart';
import 'package:artist/shared/instances.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/post_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          SizedBox(
            height: Get.height,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const TopBar(),
                    const SizedBox(
                      height: 90,
                    ),
                    TopCarousel(),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Recent Activities',
                      style: Get.textTheme.headline2,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Obx(
                () => ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: appController.feedPosts.length,
                  itemBuilder: (context, index) {
                    final post =
                        appController.feedPosts[index].data() as PostModel;
                    final postId = appController.feedPosts[index].id;
                    return UserPostItem(
                      post: post,
                      id: postId,
                      isCurrentUserPost: false,
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const Divider(thickness: 10),
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () => appController.isCurrentUserPostFetcing.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
          const Positioned(
            top: kToolbarHeight * 1.3,
            left: 0,
            right: 0,
            child: SearchBar(),
          ),
        ],
      ),
    );
  }
}
