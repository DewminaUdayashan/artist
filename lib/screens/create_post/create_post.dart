import 'package:artist/screens/create_post/widgets/post_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePost extends StatelessWidget {
  const CreatePost({Key? key}) : super(key: key);

  static final imageList = [
    'assets/images/image_1.jpg',
    'assets/images/image_2.jpg',
    'assets/images/image_3.jpg',
    'assets/images/image_4.jpg',
    'assets/images/image_5.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            splashRadius: 20,
            tooltip: 'Post',
            icon: const Icon(
              Icons.send,
              color: Colors.black54,
            ),
            onPressed: () => Get.back(),
          ),
        ],
        leading: IconButton(
          splashRadius: 20,
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black54,
          ),
        ),
        leadingWidth: 40,
        title: Text('Create Post', style: context.textTheme.headline2),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/images/user.jpg'),
                  ),
                  const SizedBox(width: 15),
                  Text('Nuwan Randhika', style: context.textTheme.bodyText1)
                ],
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Say something about this photo ...',
                  border: InputBorder.none,
                ),
                style: context.textTheme.bodyText1,
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
              const SizedBox(height: 15),
              Expanded(
                child: ListView.builder(
                  itemCount: imageList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return PostItem(
                      image: imageList[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
