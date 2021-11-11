import 'package:artist/screens/categories/widgets/main_category_item.dart';
import 'package:artist/screens/categories/widgets/searchbox.dart';
import 'package:artist/screens/categories/widgets/title_bar.dart';
import 'package:artist/screens/profile/widgets/animated_bg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainCategories extends StatelessWidget {
  const MainCategories({Key? key}) : super(key: key);

  static final categoryList = [
    {'title': 'Handicraft', 'image': 'assets/images/categories/category_1.jpg'},
    {'title': 'Art', 'image': 'assets/images/categories/category_3.jpg'},
    {'title': 'Food', 'image': 'assets/images/categories/category_4.jpg'},
    {
      'title': 'Hospitality',
      'image': 'assets/images/categories/category_2.jpg'
    },
    {
      'title': 'Architecture',
      'image': 'assets/images/categories/category_5.jpg'
    },
    {
      'title': 'Photography',
      'image': 'assets/images/categories/category_6.png'
    },
    {'title': 'Music', 'image': 'assets/images/categories/category_7.png'},
    {'title': 'Drama', 'image': 'assets/images/categories/category_8.png'},
    {'title': 'Dancing', 'image': 'assets/images/categories/category_9.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          height: Get.height / 1.5,
          width: Get.width,
          color: const Color(0xff35B7F1),
        ),
        const AnimatedBg(),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          top: 210,
          child: Container(
            // height: Get.height / 1.6,
            width: Get.width,
            decoration: BoxDecoration(
              color: context.theme.scaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: GridView.count(
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                crossAxisCount: 2,
                children: List.generate(
                  categoryList.length,
                  (index) {
                    return MainCategoryItem(
                      details: categoryList[index],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        const SearchBox(),
        TitleBar(
          title: 'Categories',
        ),
      ],
    );
  }
}
