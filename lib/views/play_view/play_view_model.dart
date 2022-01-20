import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:youtube_dl/controllers/src/down_controller.dart';
import 'package:youtube_dl/controllers/src/play_controller.dart';
import 'package:youtube_dl/models/youtube-dl.dart';
import 'package:youtube_dl/utils/format.dart';

class PlayViewModel {
  final PlayController _playController = PlayController.find();
  final DownController _dlController = DownController.find();

  bool get isLoading => _playController.isLoading;

  List<YoutubeDl> get dlList => _dlController.dlList;

  String get totalDurationText =>
      Format.playerDuration(_playController.totalMilSec);

  int get currentDuration {
    return _seekMode ? _seekMilSec.value : _playController.currentMilSec;
  }

  String get currentDurationText => Format.playerDuration(currentDuration);

  double get progress => currentDuration / _playController.totalMilSec;

  void onSelectItem(YoutubeDl dl) {
    _playController.playItem(dl);
  }

  void onTapPlay() {
    _playController.playCurrent();
  }

  void onTapPause() {
    _playController.pause();
  }

  bool _seekMode = false;
  final RxInt _seekMilSec = 0.obs;

  void onStartSeek(double value) {
    _seekMilSec((_playController.totalMilSec * value).toInt());
    _seekMode = true;
  }

  void onChangeSeek(double value) {
    _seekMilSec((_playController.totalMilSec * value).toInt());
  }

  void onEndSeek(double value) async {
    _seekMode = false;
    await _playController.seek(_seekMilSec.value);
    _seekMilSec(0);
  }
}
