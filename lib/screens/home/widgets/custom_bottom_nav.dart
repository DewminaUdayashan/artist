import 'package:artist/controllers/app_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomNav extends GetWidget<AppController> {
  const CustomBottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () => controller.onTabTapped(0),
              icon: Icon(
                controller.selectedPage.value == 0
                    ? CupertinoIcons.house_fill
                    : CupertinoIcons.house,
                color: controller.selectedPage.value == 0
                    ? Colors.blue
                    : Colors.grey,
              ),
            ),
            IconButton(
              onPressed: () => controller.onTabTapped(1),
              icon: Icon(
                controller.selectedPage.value == 1
                    ? CupertinoIcons.chat_bubble_text_fill
                    : CupertinoIcons.chat_bubble_text,
                color: controller.selectedPage.value == 1
                    ? Colors.blue
                    : Colors.grey,
              ),
            ),
            IconButton(
              onPressed: () => controller.onTabTapped(2),
              icon: Icon(
                controller.selectedPage.value == 2
                    ? CupertinoIcons.bell_fill
                    : CupertinoIcons.bell,
                color: controller.selectedPage.value == 2
                    ? Colors.blue
                    : Colors.grey,
              ),
            ),
            IconButton(
              onPressed: () => controller.onTabTapped(3),
              icon: Icon(
                controller.selectedPage.value == 3
                    ? CupertinoIcons.person_fill
                    : CupertinoIcons.person,
                color: controller.selectedPage.value == 3
                    ? Colors.blue
                    : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
