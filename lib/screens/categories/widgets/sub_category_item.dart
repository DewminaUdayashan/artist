import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SubCategoryItem extends StatelessWidget {
  SubCategoryItem({Key? key, required this.details}) : super(key: key);

  Map<String, String> details;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 150,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 30,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    details['image']!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 5,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    details['title']!,
                    style: context.textTheme.bodyText1!.copyWith(fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
