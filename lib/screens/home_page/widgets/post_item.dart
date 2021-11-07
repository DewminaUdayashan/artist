import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PostItem extends StatelessWidget {
  const PostItem({Key? key}) : super(key: key);

  static final _pageController = PageController(initialPage: 0);

  static final imageList = [
    'assets/images/image_1.jpg',
    'assets/images/image_2.jpg',
    'assets/images/image_3.jpg',
    'assets/images/image_4.jpg',
    'assets/images/image_5.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                child: Row(
                  children: <Widget>[
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/user.jpg'),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Nuwan Dhanushka',
                            style: context.textTheme.headline2!
                                .copyWith(color: Colors.black54)),
                        Text('2 hours ago', style: context.textTheme.bodyText2),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
                // splashRadius: 15,
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 10),
          Text(
            "Thanks for creating .....its really awesome I m using in my android app",
            style: context.textTheme.bodyText1,
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            height: 300,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: PageView.builder(
                    itemCount: imageList.length,
                    controller: _pageController,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        imageList[index],
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(1),
                          Colors.black.withOpacity(0.4),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.favorite_border_outlined,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  '142',
                                  style: context.textTheme.bodyText2!
                                      .copyWith(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          SmoothPageIndicator(
                            controller: _pageController,
                            count: imageList.length,
                            effect: ScrollingDotsEffect(
                                activeDotColor: context.theme.primaryColor,
                                activeStrokeWidth: 2.6,
                                activeDotScale: 1.5,
                                maxVisibleDots: 5,
                                radius: 3,
                                spacing: 10,
                                dotHeight: 6,
                                dotWidth: 6,
                                dotColor: Colors.grey[400]!),
                          ),
                          SizedBox(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.message_rounded,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  '21',
                                  style: context.textTheme.bodyText2!
                                      .copyWith(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ],
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
  }
}
