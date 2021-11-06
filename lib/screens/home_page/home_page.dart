import 'package:artist/screens/home_page/widgets/search_bar.dart';
import 'package:artist/screens/home_page/widgets/top_bar.dart';
import 'package:artist/screens/home_page/widgets/top_carousel.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const <Widget>[
            TopBar(),
            SearchBar(),
            TopCarousel(),
          ],
        ),
      ),
    );
  }
}
