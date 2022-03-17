import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_dl/views/play_view/src/play_list_view.dart';
import 'package:youtube_dl/views/search_view/search_view.dart';

class HomeViewModel {
  final String searchTag = "searchTag";

  void onTapSearch() {
    Get.to(
      () => SearchView(searchTag: searchTag),
      transition: Transition.fadeIn,
    );
  }

  /// drawer
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void onTapLeading() {
    scaffoldKey.currentState!.openDrawer();
  }

  void onTapBottom() {
    Get.to(
      () => PlayListView(),
      transition: Transition.downToUp,
    );
  }
}
