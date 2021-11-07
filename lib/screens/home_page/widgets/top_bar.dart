import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome back!', style: context.textTheme.bodyText2),
            Row(
              children: <Widget>[
                Text('Helena Angel ',
                    style: context.textTheme.headline2!.copyWith(fontSize: 22)),
                Lottie.asset('assets/json/hand.json', width: 30),
              ],
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications_none_outlined,
            size: 30,
          ),
          splashRadius: 20,
        ),
      ],
    );
  }
}
