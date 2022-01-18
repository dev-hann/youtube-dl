import 'package:get/get.dart';
import 'package:youtube_dl/controllers/src/down_controller.dart';
import 'package:youtube_dl/controllers/src/play_controller.dart';
import 'package:youtube_dl/models/youtube-dl.dart';

class PlayViewModel {
  final PlayController _playController = PlayController.find();
  final DownController _dlController = DownController.find();

  List<YoutubeDl> get dlList => _dlController.dlList;

  void onSelectItem(YoutubeDl dl) async {
    await _playController.setItem(dl);
    onTapPlay();
  }

  void onTapPlay() {
    if (_playController.currentItem == null) return;
    _playController.play();
  }

  void onTapPause() {
    _playController.pause();
  }
}
