import 'package:artist/controllers/app_controller.dart';
import 'package:artist/screens/home/widgets/custom_bottom_nav.dart';
import 'package:artist/screens/home_page/home_page.dart';
import 'package:artist/screens/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

const pages = [
  HomePage(),
  Center(
    child: Text(
      '2',
      style: TextStyle(
        color: Colors.black,
      ),
    ),
  ),
  Center(
    child: Text(
      '3',
      style: TextStyle(
        color: Colors.black,
      ),
    ),
  ),
  Profile(),
];

class Home extends GetWidget<AppController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          controller: controller.pageController,
          itemCount: pages.length,
          onPageChanged: controller.onPageChanged,
          itemBuilder: (context, index) {
            return pages[index];
          },
        ),
      ),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }
}
