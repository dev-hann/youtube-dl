import 'package:youtube_dl/controllers/src/play_controller.dart';
import 'package:youtube_dl/models/youtube_dl.dart';
import 'package:youtube_dl/views/play_view/src/play_list_view.dart';

class MiniPlayViewModel {
  final PlayController _playController = PlayController.find();


  YoutubeDl? get currentItem => _playController.currentItem;

  bool get isPlaying => _playController.isPlaying;

  double get progress =>
      _playController.position.inMilliseconds /
      _playController.duration.inMilliseconds;

  void onTapPlayButton() {
    _playController.playToggle();
  }

  void onTapListView() {
    PlayListView.goToPlayListView();
  }

  Future onTapForward() async {
    await _playController.forward();
  }

  Future onTapBackward() async {
    await _playController.backward();
  }

}
