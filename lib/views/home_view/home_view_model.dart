import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_dl/views/search_view/search_view.dart';

class HomeViewModel {
  final String searchTag = "searchTag";

  void onTapSearch() {
    Get.to(
      () => SearchView(
        searchTag: searchTag,
      ),
      transition: Transition.downToUp,
    );
  }

  /// drawer
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void onTapLeading() {
    scaffoldKey.currentState!.openDrawer();
  }
}
