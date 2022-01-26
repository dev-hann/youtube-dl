import 'package:get/get.dart';
import 'package:youtube_dl/controllers/src/play_controller.dart';
import 'package:youtube_dl/models/youtube_dl.dart';

class MiniPlayViewModel {
  final PlayController _playController = PlayController.find();

  bool get isPlayListView => Get.currentRoute == "/PlayListView";

  YoutubeDl? get currentItem => _playController.currentItem;

  bool get isPlaying => _playController.isPlaying;

  double get progress =>
      _playController.position.inMilliseconds /
      _playController.duration.inMilliseconds;

  void onTapPlayButton() {
    _playController.playToggle();
  }
}
