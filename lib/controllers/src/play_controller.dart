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
    _init();
    super.onReady();
  }

  final RxBool _loading = true.obs;

  bool get isLoading => _loading.value;

  void _init() async {
    _useCase = PlayUseCase(PlayImpl());
    await _useCase.init();
    _initPlayerStateListener();
    _initDurationListener();
    _initPositionListener();
    _loading(false);
  }

  /// PlayState Stream
  final RxBool _playing = false.obs;

  bool get isPlaying => _playing.value;

  late StreamSubscription _playerStateSub;

  void _initPlayerStateListener() {
    _playerStateSub = _useCase.playerStateStream.listen((event) {
      _playing(event.playing);
    });
  }

  void _disposePlayerStateListener() {
    _playerStateSub.cancel();
  }

  /// Position Stream
  final Rx<Duration> _position = Duration.zero.obs;

  Duration get position => _position.value;

  late StreamSubscription _positionStreamSub;

  void _initPositionListener() {
    _positionStreamSub = _useCase.positionStream.listen((event) {
      _position(event);
    });
  }

  void _disposePositionListener() {
    _positionStreamSub.cancel();
  }

  /// Duration Stream
  final Rx<Duration> _duration = const Duration(milliseconds: 1).obs;

  Duration get duration => _duration.value;

  late StreamSubscription _durationSub;

  void _initDurationListener() {
    _durationSub = _useCase.durationStream.listen((event) {
      if (event == null) {
        _duration(const Duration(milliseconds: 1));
        return;
      } else {
        _duration(event);
      }
    });
  }

  void _disposeDurationListener() {
    _durationSub.cancel();
  }

  Future setYoutubeDl(YoutubeDl dl) async {
    _currentItem(dl);
    await _useCase.setYoutubeDl(dl);
  }

  Future playToggle() async {
    if (isPlaying) {
      stop();
      return;
    }
    play();
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

  Future clearCurrentDl() async {
    final _dl = currentItem;
    _currentItem.value = null;
  }
}
