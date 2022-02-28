import 'package:youtube_dl/controllers/src/audio_controller.dart';
import 'package:youtube_dl/models/youtube_dl.dart';
import 'package:youtube_dl/views/play_view/src/play_list_view.dart';

class MiniPlayViewModel {
  final AudioController audioController = AudioController.find();


  YoutubeDl? get currentItem => audioController.currentItem;

  bool get isPlaying => audioController.isPlaying;

  double get progress =>
      audioController.position.inMilliseconds /
      audioController.duration.inMilliseconds;

  void onTapPlayButton() {
    audioController.playToggle();
  }

  void onTapListView() {
    PlayListView.goToPlayListView();
  }

  Future onTapForward() async {
    await audioController.forward();
  }

  Future onTapBackward() async {
    await audioController.backward();
  }

}
