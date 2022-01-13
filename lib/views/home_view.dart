import 'package:flutter/material.dart';

import 'home_view/search_view/search_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  AppBar _appBar() {
    return AppBar(title: const Text("youtube-dl"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: PageView(
        children: [
          SearchView(),
        ],
      ),
    );
  }
}
// https://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@github.com/yoehwan/youtube-dl-server.git
