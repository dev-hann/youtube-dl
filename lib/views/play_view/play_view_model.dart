import 'dart:async';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:get/get.dart';
import 'package:youtube_dl/controllers/src/audio_controller.dart';
import 'package:youtube_dl/controllers/src/youtube_controller.dart';
import 'package:youtube_dl/enums/play_repeat_state.dart';
import 'package:youtube_dl/models/play_list.dart';
import 'package:youtube_dl/models/youtube_dl.dart';
import 'package:youtube_dl/utils/format.dart';
import 'package:youtube_dl/views/play_view/src/play_list_view.dart';

class PlayViewModel {
  final AudioController audioController = AudioController.find();

  final YoutubeController _dlController = YoutubeController.find();

  bool get isPlaying => audioController.isPlaying;

  bool get isLoading => audioController.isLoading || _dlController.isLoading;

  PlayList get playList => audioController.playList;

  List<YoutubeDl> get dlList {
    return _dlController.findItemList(playList.videoIdList);
  }

  String get durationText => Format.playerDuration(audioController.duration);

  double get progress {
    if (_seekMode.value) return _seekPercent.value;
    return (audioController.position.inMilliseconds /
            audioController.duration.inMilliseconds)
        .clamp(0, 1);
  }

  String get positionText {
    if (!_seekMode.value) {
      return Format.playerDuration(audioController.position);
    }
    return Format.playerDuration(Duration(milliseconds: seekNormalized));
  }

  /// pageController
  late StreamSubscription _itemChangeSub;

  void init() {
    _itemChangeSub = audioController.currentItemStream.listen((event) {
      if (event == null || event == currentItem) return;
      final index =
          dlList.indexWhere((element) => element.videoId == event.videoId);
      pageController.jumpToPage(index);
    });
  }

  void dispose() {
    _itemChangeSub.cancel();
  }

  CarouselControllerImpl get pageController => audioController.pageController;

  final RxInt _currentPage = 0.obs;

  int get currentPage => _currentPage.value;

  Future<void> onChangedPage(int page, CarouselPageChangedReason reason) async {
    _currentPage(page);
    if (reason == CarouselPageChangedReason.controller) return;
    final _isPlaying = audioController.isPlaying;

    await audioController.stop();
    await audioController.setYoutubeDl(currentItem!);
    if (_isPlaying) {
      await audioController.play();
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

  YoutubeDl? get playingItem => audioController.currentItem;

  Future<void> onTapPlay() async {
    if (currentItem == null) return;
    if (playingItem == currentItem) {
      audioController.playToggle();
    } else {
      await audioController.setYoutubeDl(currentItem!);
      audioController.play();
    }
  }

  final RxBool _seekMode = false.obs;
  final RxDouble _seekPercent = 0.0.obs;

  int get seekNormalized =>
      (audioController.duration.inMilliseconds * _seekPercent.value).toInt();

  void onStartSeek(double value) {
    _seekPercent(value);
    _seekMode(true);
  }

  void onChangeSeek(double value) {
    _seekPercent(value);
  }

  void onEndSeek(double value) async {
    _seekMode(false);
    await audioController.seek(seekNormalized);
    _seekPercent(0);
  }

  void onTapPlayList() {
    PlayListView.goToPlayListView();
  }

  Future onTapForward() async {
    await audioController.forward();
  }

  Future onTapBackward() async {
    await audioController.backward();
  }

  PlayRepeatState get repeatState => audioController.repeatState;

  Future onTapMode() async {
    final nextIndex = (repeatState.index + 1) % 3;
    final nextState = PlayRepeatState.values[nextIndex];
    await audioController.setPlayaRepeatMode(nextState);
  }
}
