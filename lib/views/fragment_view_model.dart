import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FragmentViewModel {
  final PageController pageController = PageController();

  final RxInt _currentIndex = 0.obs;

  int get currentIndex => _currentIndex.value;

  void jumpPage(int index) {
    _currentIndex(index);
    pageController.jumpToPage(index);
  }
}
