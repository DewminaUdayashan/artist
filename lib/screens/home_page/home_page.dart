import 'package:artist/screens/create_post/create_post.dart';
import 'package:artist/screens/home_page/widgets/search_bar.dart';
import 'package:artist/screens/home_page/widgets/top_bar.dart';
import 'package:artist/screens/home_page/widgets/top_carousel.dart';
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (_, index) => const PostItem(),
                ),
              ],
            ),
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
