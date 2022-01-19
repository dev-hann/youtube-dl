import 'dart:async';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:youtube_dl/models/youtube-dl.dart';
import 'package:youtube_dl/repos/play_repo/src/play_impl.dart';
import 'package:youtube_dl/use_cases/play_use_case/play_use_case.dart';

class PlayController extends GetxService {
  static PlayController find() => Get.find<PlayController>();

  late PlayUseCase _useCase;
  final Rxn<YoutubeDl> _currentItem = Rxn();

  YoutubeDl? get currentItem => _currentItem.value;

  @override
  void onReady() {
    _useCase = PlayUseCase(PlayImpl());
    super.onReady();
  }

  Future setItem(YoutubeDl dl) async {
    _currentItem(dl);
    await _useCase.init(
      dl.path!,
      onChangedState,
      onChangedDuration,
    );
  }

  void onChangedState(PlayerState state) {}
  final RxInt _totalMilSec = 0.obs;

  int get totalMilSec {
    if (_totalMilSec.value == 0) {
      return 1;
    }
    return _totalMilSec.value;
  }

  final RxInt _currentMilSec = 0.obs;

  int get currentMilSec => _currentMilSec.value;

  void onChangedDuration(int current, int total) {
    _currentMilSec(current);
    _totalMilSec(total);
  }

  Future play() async {
    if (currentItem == null) return;
    await _useCase.play();
  }

  Future pause() async {
    await _useCase.pause();
  }

  Future stop() async {
    await _useCase.stop();
  }

  Future seek(int milSec) async {
    await _useCase.seek(milSec);
  }
}
