import 'package:artist/shared/instances.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({
    Key? key,
    this.isViewer = false,
  }) : super(key: key);

  final bool isViewer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appController.currentUser!.bio ?? 'Add your bio here 😎',
          style: context.textTheme.headline3,
        ),
        if (isViewer) ...[]
      ],
    );
  }
}
