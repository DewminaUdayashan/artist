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
        Material(
          color: Colors.transparent,
          elevation: 1,
          borderRadius: BorderRadius.circular(15),
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {},
            child: Ink(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: const Icon(Icons.notifications_none_rounded),
            ),
          ),
        ),
      ],
    );
  }
}
