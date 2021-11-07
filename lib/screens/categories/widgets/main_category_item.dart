import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainCategoryItem extends StatelessWidget {
  const MainCategoryItem({Key? key, required this.details}) : super(key: key);

  final Map<String, String> details;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(15),
        child: Ink(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    details['image']!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      details['title']!,
                      style: context.textTheme.bodyText2!.copyWith(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
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
