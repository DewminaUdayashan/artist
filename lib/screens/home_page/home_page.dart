import 'package:artist/screens/home_page/widgets/search_bar.dart';
import 'package:artist/screens/home_page/widgets/top_bar.dart';
import 'package:artist/screens/home_page/widgets/top_carousel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                height: Get.height,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: const <Widget>[
                    TopBar(),
                    SizedBox(
                      height: 90,
                    ),
                    TopCarousel(),
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
        ),
      ),
    );
  }
}
