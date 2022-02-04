import 'dart:async';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:youtube_dl/controllers/src/download_controller.dart';
import 'package:youtube_dl/controllers/src/play_controller.dart';
import 'package:youtube_dl/controllers/src/play_list_controller.dart';
import 'package:youtube_dl/enums/play_repeat_state.dart';
import 'package:youtube_dl/models/play_list.dart';
import 'package:youtube_dl/models/youtube_dl.dart';
import 'package:youtube_dl/utils/format.dart';
import 'package:youtube_dl/views/play_view/src/play_list_view.dart';

class PlayViewModel {
  final PlayController _playController = PlayController.find();
  final DownloadController _dlController = DownloadController.find();

  bool get isPlaying => _playController.isPlaying;

  bool get isLoading => _playController.isLoading || _dlController.isLoading;

  PlayList get playList => _playController.playList;

  List<YoutubeDl> get dlList {
    return _dlController.findItemList(playList.videoIdList);
  }

  String get durationText => Format.playerDuration(_playController.duration);

  double get progress {
    if (_seekMode.value) return _seekPercent.value;
    return (_playController.position.inMilliseconds /
            _playController.duration.inMilliseconds)
        .clamp(0, 1);
  }

  String get positionText {
    if (!_seekMode.value) {
      return Format.playerDuration(_playController.position);
    }
    return Format.playerDuration(Duration(milliseconds: seekNormalized));
  }

  /// pageController
  late StreamSubscription _itemChangeSub;

  void init() {
    _itemChangeSub = _playController.currentItemStream.listen((event) {
      if (event == null || event == currentItem) return;
      final index =
          dlList.indexWhere((element) => element.videoId == event.videoId);
      pageController.jumpToPage(index);
    });
  }

  void dispose() {
    _itemChangeSub.cancel();
  }

  CarouselControllerImpl get pageController => _playController.pageController;

  final RxInt _currentPage = 0.obs;

  int get currentPage => _currentPage.value;

  Future<void> onChangedPage(int page, CarouselPageChangedReason reason) async {
    _currentPage(page);
    if (reason == CarouselPageChangedReason.controller) return;
    final _isPlaying = _playController.isPlaying;

    await _playController.stop();
    await _playController.setYoutubeDl(currentItem!);
    if (_isPlaying) {
      await _playController.play();
    }
  }

  /// Button Handel
  YoutubeDl? get currentItem {
    if (dlList.isEmpty) return null;
    return dlList[currentPage];
  }

  String get title {
    if (currentItem == null) return "";
    return currentItem!.title;
  }

  YoutubeDl? get playingItem => _playController.currentItem;

  Future<void> onTapPlay() async {
    if (currentItem == null) return;
    if (playingItem == currentItem) {
      _playController.playToggle();
    } else {
      await _playController.setYoutubeDl(currentItem!);
      _playController.play();
    }
  }

  final RxBool _seekMode = false.obs;
  final RxDouble _seekPercent = 0.0.obs;

  int get seekNormalized =>
      (_playController.duration.inMilliseconds * _seekPercent.value).toInt();

  void onStartSeek(double value) {
    _seekPercent(value);
    _seekMode(true);
  }

  void onChangeSeek(double value) {
    _seekPercent(value);
  }

  void onEndSeek(double value) async {
    _seekMode(false);
    await _playController.seek(seekNormalized);
    _seekPercent(0);
  }

  void onTapPlayList() {
    PlayListView.goToPlayListView();
  }

  Future onTapForward() async {
    await _playController.forward();
  }

  Future onTapBackward() async {
    await _playController.backward();
  }

  PlayRepeatState get repeatState => _playController.repeatState;

  Future onTapMode() async {
    final nextIndex = (repeatState.index + 1) % 3;
    final nextState = PlayRepeatState.values[nextIndex];
    await _playController.setPlayaRepeatMode(nextState);
  }
}
