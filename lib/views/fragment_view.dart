import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_dl/const/color.dart';
import 'package:youtube_dl/views/home_view/home_view.dart';

import 'fragment_view_model.dart';
import 'play_view/play_view.dart';

class FragmentView extends StatelessWidget {
  FragmentView({Key? key}) : super(key: key);
  final FragmentViewModel _viewModel = FragmentViewModel();

  Widget _bottom() {
    return Obx(() {
      return BottomNavigationBar(
        backgroundColor: DlBlackColor,
        currentIndex: _viewModel.currentIndex,
        onTap: _viewModel.jumpPage,
        unselectedItemColor: DlGreyColor,
        selectedLabelStyle: const TextStyle(fontSize: 16),
        unselectedLabelStyle: const TextStyle(fontSize: 14),
        selectedIconTheme: const IconThemeData(size: 26),
        unselectedIconTheme: const IconThemeData(color: DlGreyColor),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: "Music",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
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
        children: const [
          PlayView(),
          HomeView(),
        ],
      ),
      bottomNavigationBar: _bottom(),
    );
  }
}
