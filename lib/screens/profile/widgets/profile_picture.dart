import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: Get.height / 2.7,
      left: 30,
      child: Container(
        height: 120,
        width: 120,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            'https://modernpaintbynumbers.com/wp-content/uploads/2020/10/Megan-Ramsey-paint-by-number.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
