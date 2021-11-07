import 'package:artist/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({Key? key, this.user}) : super(key: key);
  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: const Color(0xffF5F5F5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: user == null
                ? Image.asset(
                    'assets/images/user.jpg',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  )
                : OctoImage(
                    image: NetworkImage(user!.imageUrl!),
                  ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user == null ? 'Randhika Chathuranga' : user!.name!,
                  style: context.textTheme.headline2!
                      .copyWith(color: Colors.black54),
                ),
                const SizedBox(height: 5),
                Text(
                  'Music Director',
                  style: context.textTheme.bodyText2,
                ),
              ],
            ),
          ),
          IconButton(
            splashRadius: 10,
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert_rounded,
            ),
          ),
        ],
      ),
    );
  }
}//
