import 'dart:ui';

import 'package:artist/helpers/firestore_helper.dart';
import 'package:artist/models/post_model.dart';
import 'package:artist/models/user_model.dart';
import 'package:artist/shared/instances.dart';
import 'package:artist/shared/utils.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:octo_image/octo_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:video_player/video_player.dart';

class PostItem extends StatefulWidget {
  const PostItem({Key? key}) : super(key: key);

  static final imageList = [
    'assets/images/image_1.jpg',
    'assets/images/image_2.jpg',
    'assets/images/image_3.jpg',
    'assets/images/image_4.jpg',
    'assets/images/image_5.jpg',
  ];

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  final _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                child: Row(
                  children: <Widget>[
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/user.jpg'),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Nuwan Dhanushka',
                            style: context.textTheme.headline2!
                                .copyWith(color: Colors.black54)),
                        Text('2 hours ago', style: context.textTheme.bodyText2),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
                // splashRadius: 15,
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 10),
          Text(
            "Thanks for creating .....its really awesome I m using in my android app",
            style: context.textTheme.bodyText1,
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            height: 300,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: PageView.builder(
                    itemCount: PostItem.imageList.length,
                    controller: _pageController,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        PostItem.imageList[index],
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(1),
                          Colors.black.withOpacity(0.4),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.favorite_border_outlined,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  '142',
                                  style: context.textTheme.bodyText2!
                                      .copyWith(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          SmoothPageIndicator(
                            controller: _pageController,
                            count: PostItem.imageList.length,
                            effect: ScrollingDotsEffect(
                                activeDotColor: context.theme.primaryColor,
                                activeStrokeWidth: 2.6,
                                activeDotScale: 1.5,
                                maxVisibleDots: 5,
                                radius: 3,
                                spacing: 10,
                                dotHeight: 6,
                                dotWidth: 6,
                                dotColor: Colors.grey[400]!),
                          ),
                          SizedBox(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.message_rounded,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  '21',
                                  style: context.textTheme.bodyText2!
                                      .copyWith(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UserPostItem extends StatefulWidget {
  const UserPostItem({
    Key? key,
    required this.post,
    required this.id,
    this.isCurrentUserPost = true,
  }) : super(key: key);
  final PostModel post;
  final String id;
  final bool isCurrentUserPost;

  @override
  State<UserPostItem> createState() => _UserPostItemState();
}

class _UserPostItemState extends State<UserPostItem> {
  final _pageController = PageController(initialPage: 0);
  List<String> media = List<String>.empty(growable: true);
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  late PostModel post;
  UserModel? user;

  @override
  void initState() {
    super.initState();
    post = widget.post;
    if (widget.isCurrentUserPost) {
      user = appController.currentUser.value;
    } else {
      getUser();
    }
    media.addAll(post.mediaUrls ?? []);
    _initializeVideo();
  }

  Future<void> getUser() async {
    final snap = await FirestoreHelper.getUser(post.userId!);
    user = snap.data() as UserModel;
    setState(() {});
  }

  Future<void> _initializeVideo() async {
    for (String url in media) {
      if (!isImage(url)) {
        videoPlayerController = VideoPlayerController.network(
          url,
        );
        await videoPlayerController!.initialize();

        chewieController = ChewieController(
          videoPlayerController: videoPlayerController!,
          autoPlay: false,
          looping: true,
          allowFullScreen: false,
        );
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    if (videoPlayerController != null) videoPlayerController!.dispose();
    if (chewieController != null) chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 16),
              Row(
                children: <Widget>[
                  user == null
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(
                            user!.imageUrl!,
                          ),
                        ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        user == null ? 'loading..' : user!.name!,
                        style: context.textTheme.headline2!.copyWith(
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        timeago.format(
                          DateTime.tryParse(post.date!) ?? DateTime.now(),
                        ),
                        style: context.textTheme.bodyText2,
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
                // splashRadius: 15,
              ),
            ],
          ),
          const Divider(),
          if (post.description != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                post.description ?? '',
                style: context.textTheme.bodyText1,
              ),
            ),
            const SizedBox(height: 20),
          ],
          if (media.isNotEmpty) ...[
            media.length == 1
                ? isImage(media.first)
                    ? Center(
                        child: OctoImage(
                          image: NetworkImage(media.first),
                          alignment: Alignment.center,
                          placeholderBuilder: (_) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      )
                    : chewieController != null
                        ? AspectRatio(
                            aspectRatio:
                                videoPlayerController!.value.aspectRatio,
                            child: Chewie(
                              controller: chewieController!,
                            ),
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text('Video Loading..'),
                              SizedBox(height: 5),
                              LinearProgressIndicator(
                                backgroundColor: Colors.white,
                              ),
                            ],
                          )
                : Column(
                    children: [
                      SizedBox(
                        height: Get.height / 2,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: media.length,
                          pageSnapping: true,
                          itemBuilder: (context, index) {
                            return isImage(media[index])
                                ? Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              media[index],
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      GlassContainer.clearGlass(
                                        height: Get.height / 2,
                                        width: Get.width,
                                        blur: 40,
                                      ),
                                      OctoImage(
                                        image: NetworkImage(
                                          media[index],
                                        ),
                                        placeholderBuilder: (context) =>
                                            const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                    ],
                                  )
                                : chewieController != null
                                    ? AspectRatio(
                                        aspectRatio: videoPlayerController!
                                            .value.aspectRatio,
                                        child: Chewie(
                                          controller: chewieController!,
                                        ),
                                      )
                                    : Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          Text('Video Loading..'),
                                          SizedBox(height: 5),
                                          LinearProgressIndicator(
                                            backgroundColor: Colors.white,
                                          ),
                                        ],
                                      );
                          },
                        ),
                      ),
                      const SizedBox(height: 7),
                      SmoothPageIndicator(
                        controller: _pageController,
                        count: media.length,
                        effect: WormEffect(
                          activeDotColor: context.theme.primaryColor,
                          strokeWidth: 5,
                          radius: 5,
                          spacing: 10,
                          dotHeight: 8,
                          dotWidth: 8,
                          dotColor: Colors.grey[400]!,
                        ),
                      ),
                    ],
                  ),
          ],
          Row(
            children: [
              IconButton(
                onPressed: () {
                  if (post.votes
                      .contains(appController.currentUser.value.id!)) {
                    print('removing');
                    FirestoreHelper.unvoteToPost(widget.id);
                    post.votes.remove(appController.currentUser.value.id!);
                    setState(() {});
                  } else {
                    print('liking');
                    post.votes.add(appController.currentUser.value.id!);
                    FirestoreHelper.voteToPost(widget.id);
                    setState(() {});
                  }
                },
                icon: Icon(
                  post.votes.contains(appController.currentUser.value.id)
                      ? CupertinoIcons.heart_fill
                      : CupertinoIcons.suit_heart,
                  color: post.votes.contains(appController.currentUser.value.id)
                      ? Colors.pinkAccent
                      : Colors.grey,
                ),
              ),
              Text(post.votes.length.toString()),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
