import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:youtube_dl/views/home_view/home_view.dart';

import 'fragment_view_model.dart';
import 'play_view/play_view.dart';
import 'search_view/search_view.dart';

class FragmentView extends StatelessWidget {
  FragmentView({Key? key}) : super(key: key);
  final FragmentViewModel _viewModel = FragmentViewModel();

  Widget _bottom() {
    return Obx(() {
      return BottomNavigationBar(
        currentIndex: _viewModel.currentIndex,
        onTap: _viewModel.jumpPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Ionicons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.home),
            label: "Home",
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _viewModel.pageController,
        children: [
          PlayView(),
          const SearchView(),
          const HomeView(),
        ],
      ),
      bottomNavigationBar: _bottom(),
    );
  }
}
