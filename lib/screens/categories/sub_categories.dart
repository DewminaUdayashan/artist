import 'package:artist/screens/categories/widgets/searchbox.dart';
import 'package:artist/screens/categories/widgets/sub_category_item.dart';
import 'package:artist/screens/categories/widgets/title_bar.dart';
import 'package:artist/screens/profile/widgets/animated_bg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubCategories extends StatefulWidget {
  const SubCategories({Key? key}) : super(key: key);

  static final subCategoryList = [
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
  State<SubCategories> createState() => _SubCategoriesState();
}

class _SubCategoriesState extends State<SubCategories> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(onListen);
    // _scrollController.
    super.initState();
  }

  void onListen() {
    // print(scrollController.offset);
    setState(() {});
  }

  @override
  void dispose() {
    _scrollController.removeListener(onListen);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              height: Get.height / 1.5,
              width: Get.width,
              color: const Color(0xff35B7F1),
            ),
            const AnimatedBg(),
            Positioned(
              top: 80,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 190,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: SubCategories.subCategoryList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return SubCategoryItem(
                      details: SubCategories.subCategoryList[index],
                    );
                  },
                ),
              ),
            ),
            // recruiter
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 300,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: context.theme.scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    // topLeft: Radius.circular(20),
                    topRight: Radius.circular(30),
                  ),
                ),
                // child: ListView.builder(
                //   itemBuilder: (BuildContext context, int index) {
                //     return Container();
                //   },
                // ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Members', style: context.textTheme.headline2),
                    const SizedBox(height: 15),
                    Expanded(
                      child: CustomScrollView(
                        controller: _scrollController,
                        physics: const BouncingScrollPhysics(),
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final itemPositionOffset = index * 100;
                                final deference = _scrollController.offset -
                                    itemPositionOffset;
                                final percent = 1 - (deference / 100);
                                double opacity = percent;
                                double scale = percent;
                                if (opacity < 0) opacity = 0;
                                if (opacity > 1) opacity = 1;
                                if (percent > 1) scale = 1;
                                // ignore: avoid_print
                                if (index == 0) print(deference);

                                return Opacity(
                                  opacity: opacity.toDouble(),
                                  child: Transform(
                                    alignment: Alignment.bottomCenter,
                                    transform: Matrix4.identity()
                                      ..scale(scale.toDouble(),
                                          scale.toDouble(), scale.toDouble()),
                                    child: Container(
                                      height: 100,
                                      margin: const EdgeInsets.only(bottom: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              childCount: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // const SearchBox(),
            TitleBar(
              title: 'Sub Categories',
            ),
          ],
        ),
      ),
    );
  }
}
