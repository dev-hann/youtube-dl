import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:youtube_dl/controllers/src/down_controller.dart';
import 'package:youtube_dl/controllers/src/play_controller.dart';
import 'package:youtube_dl/models/youtube-dl.dart';
import 'package:youtube_dl/utils/format.dart';
import 'package:youtube_dl/views/play_view/src/play_list_view.dart';

class PlayViewModel {
  final PlayController _playController = PlayController.find();
  final DownController _dlController = DownController.find();
  bool get isPlaying=> _playController.isPlaying;
  bool get isLoading => _playController.isLoading;

  List<YoutubeDl> get dlList => _dlController.dlList;

  String get durationText => Format.playerDuration(_playController.duration);

  double get progress {
    return _playController.position.inMilliseconds /
        _playController.duration.inMilliseconds;
  }

  String get positionText {
    if (!_seekMode) {
      return Format.playerDuration(_playController.position);
    }
    return Format.playerDuration(Duration(milliseconds: seekNormalized));
  }

  /// pageController
  final CarouselController controller = CarouselController();
  int currentPage = 0;

  void onChangedPage(int page, CarouselPageChangedReason reason) {
    currentPage = page;
  }

  void jumpNexPage() {
    controller.jumpToPage(currentPage + 1);
  }

  void onSelectItem(YoutubeDl dl) async {
    await _playController.setYoutubeDl(dl);
    await _playController.play();
  }

  /// Button Handel
  YoutubeDl get currentItem => dlList[currentPage];

  YoutubeDl? get playingItem => _playController.currentItem;

  Future<void> onTapPlay() async {
    if (playingItem == currentItem) {
      _playController.playToggle();
    } else {
      await _playController.setYoutubeDl(currentItem);
      _playController.play();
    }
  }

  bool _seekMode = false;
  final RxDouble _seekPercent = 0.0.obs;

  int get seekNormalized =>
      (_playController.duration.inMilliseconds * _seekPercent.value).toInt();

  void onStartSeek(double value) {
    _seekPercent(value);
    _seekMode = true;
  }

  void onChangeSeek(double value) {
    _seekPercent(value);
  }

  void onEndSeek(double value) async {
    _seekMode = false;
    await _playController.seek(seekNormalized);
    _seekPercent(0);
  }

  Future removeItem(int index) async {
    final _item = dlList[index];
    if (_playController.isPlaying) {
      if (_playController.currentItem == _item) {
        await _playController.stop();
        _playController.clearCurrentDl();
      }
    }
    await _dlController.removeDl(dlList[index]);
  }

  void onTapPlayList() {
    Get.to(
      () => PlayListView(),
      transition: Transition.downToUp,
    );
  }
}
