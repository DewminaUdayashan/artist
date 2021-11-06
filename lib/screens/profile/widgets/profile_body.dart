import 'package:flutter/material.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({
    Key? key,
    this.isViewer = false,
  }) : super(key: key);

  final bool isViewer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "😇\nI'm an Actor & Director of the movie industry\nwith 10 years of experience",
        ),
        if (isViewer) ...[]
      ],
    );
  }
}
