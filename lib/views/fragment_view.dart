import 'package:flutter/material.dart';
import 'package:youtube_dl/views/home_view/home_view.dart';

import 'play_view/play_view.dart';
import 'search_view/search_view.dart';

class FragmentView extends StatelessWidget {
  const FragmentView({Key? key}) : super(key: key);

  AppBar _appBar() {
    return AppBar(title: const Text("youtube-dl"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: PageView(
        controller: PageController(initialPage: 2),
        children: [
          const SearchView(),
          const HomeView(),
          PlayView(),
        ],
      ),
    );
  }
}
