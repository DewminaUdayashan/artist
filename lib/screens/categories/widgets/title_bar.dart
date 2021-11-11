import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TitleBar extends StatelessWidget {
  TitleBar({
    Key? key,
    required this.title,
  }) : super(key: key);
  String title;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 30,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
