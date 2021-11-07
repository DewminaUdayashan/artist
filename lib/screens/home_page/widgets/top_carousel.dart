import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class TopCarousel extends StatelessWidget {
  TopCarousel({Key? key}) : super(key: key);

  final carouselImageList = [
    {
      'title': "Everything your\nneed in here",
      'link': '',
      'image': 'assets/json/carousel_image_1.json',
      'backgroundColor': const Color(0xFFe3f2fd),
      'titleColor': const Color(0xFF3E708D),
      'btnColor': const Color(0xFF00bcd4),
    },
    {
      'title': "Let's find a new job \nfor you",
      'link': '',
      'image': 'assets/json/carousel_image_2.json',
      'backgroundColor': const Color(0xFFEFEBE9),
      'titleColor': const Color(0xFF73554c),
      'btnColor': const Color(0xFF9e7a70),
    },
    {
      'title': "Let's find\nnew Friends",
      'link': '',
      'image': 'assets/json/carousel_image_3.json',
      'backgroundColor': const Color(0xFFFFDDEB),
      'titleColor': const Color(0xFFa3417e),
      'btnColor': const Color(0xFFd16fac),
    },
  ];

  @override
  Widget build(BuildContext context) {
    CarouselControllerImpl _controller = CarouselControllerImpl();
    return CarouselSlider(
      carouselController: _controller,
      options: CarouselOptions(
        autoPlayInterval: const Duration(milliseconds: 10000),
        viewportFraction: 1,
        height: 200.0,
        enlargeCenterPage: true,
        autoPlay: true,
      ),
      items: carouselImageList.map((item) {
        return Builder(
          builder: (BuildContext context) {
            return carouselItem(context: context, details: item);
          },
        );
      }).toList(),
    );
  }

  Widget carouselItem({required BuildContext context, details}) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: details['backgroundColor'],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            right: -35,
            bottom: -5,
            child: Lottie.asset(details['image'], width: 250),
          ),
          Positioned(
            top: 30,
            left: 30,
            child: Text(
              details['title'],
              style: context.textTheme.headline2!.copyWith(
                color: details['titleColor'],
                fontSize: 22,
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 30,
            child: TextButton(
              onPressed: () {},
              child: const Text("Read more"),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(
                  const Color(0xFFFFFFFF),
                ),
                backgroundColor:
                    MaterialStateProperty.all<Color>(details['btnColor']),
                elevation: MaterialStateProperty.all<double>(2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
