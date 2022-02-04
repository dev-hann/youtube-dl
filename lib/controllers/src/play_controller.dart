import 'dart:async';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import 'package:youtube_dl/enums/play_repeat_state.dart';
import 'package:youtube_dl/models/play_list.dart';
import 'package:youtube_dl/models/youtube_dl.dart';
import 'package:youtube_dl/repos/play_list_repo/src/play_list_impl.dart';
import 'package:youtube_dl/repos/play_repo/src/play_impl.dart';
import 'package:youtube_dl/use_cases/play_list_use_case/play_list_use_case.dart';
import 'package:youtube_dl/use_cases/play_use_case/play_use_case.dart';

class PlayController extends GetxService {
  static PlayController find() => Get.find<PlayController>();

  late PlayUseCase _playUseCase;

  final Rxn<YoutubeDl> _currentItem = Rxn();

  Stream<YoutubeDl?> get currentItemStream => _currentItem.stream;

  YoutubeDl? get currentItem => _currentItem.value;

  final RxBool _loading = true.obs;

  bool get isLoading => _loading.value;

  @override
  void onReady() async {
    await _initPlay();
    await _initPLayList();
    _loading(false);
    super.onReady();
  }

  Future _initPlay() async {
    _playUseCase = PlayUseCase(PlayImpl());
    await _playUseCase.init();
    _initPlayerStateListener();
    _initDurationListener();
    _initPositionListener();
  }

  /// PlayState Stream
  final RxBool _playing = false.obs;

  bool get isPlaying => _playing.value;

  late StreamSubscription _playerStateSub;

  void _initPlayerStateListener() {
    _playerStateSub = _playUseCase.playerStateStream.listen((event) {
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
    _positionStreamSub = _playUseCase.positionStream.listen((event) {
      // if (event == duration) {
      //   //or loop
      //   stop();
      // }
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
    _durationSub = _playUseCase.durationStream.listen((event) {
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
    // await _playUseCase.setYoutubeDl(dl);
  }

  Future playToggle() async {
    if (isPlaying) {
      stop();
    } else {
      play();
    }
  }

  Future play() async {
    if (currentItem == null) return;
    await _playUseCase.play();
  }

  Future pause() async {
    await _playUseCase.pause();
  }

  Future stop() async {
    await _playUseCase.stop();
  }

  Future seek(int milSec) async {
    await _playUseCase.seek(milSec);
  }

  Future forward([int seconds = 15]) async {
    final milSec =
        position.inMilliseconds + Duration(seconds: seconds).inMilliseconds;

    await _playUseCase.seek(milSec.clamp(0, duration.inMilliseconds));
  }

  Future backward([int seconds = 15]) async {
    final milSec =
        position.inMilliseconds - Duration(seconds: seconds).inMilliseconds;

    await _playUseCase.seek(milSec.clamp(0, duration.inMilliseconds));
  }

  Future clearCurrentDl() async {
    _currentItem.value = null;
  }

  /// Repeat mode
  final Rx<PlayRepeatState> _repeatState = PlayRepeatState.none.obs;

  PlayRepeatState get repeatState => _repeatState.value;

  Future setPlayaRepeatMode(PlayRepeatState state) async {
    _repeatState(state);
    await _playUseCase.playMode(state);
  }

  /// PlayList
  late PlayListUseCase _playListUseCase;
  late Rx<PlayList> _playList;

  PlayList get playList => _playList.value;

  Future _initPLayList() async {
    _playListUseCase = PlayListUseCase(PlayListImpl());
    await _playListUseCase.initUseCase();
    _playList = _playListUseCase.loadPlayList().obs;
    await setPlayList(playList);
    await setPlayaRepeatMode(PlayRepeatState.none);
  }

  Future setPlayList(PlayList playList) async {
    _playList(playList);
    await _playUseCase.setPlayList(playList.videoIdList);
  }

  Future updatePlayList(PlayList newPlayList) async {
    await _playListUseCase.updatePlayList(newPlayList);
    _playList(newPlayList);
  }

  Future reorderPlayList(int oldIndex, int newIndex) async {
    _playList.update((val) {
      final item = val!.videoIdList.removeAt(oldIndex);
      val.videoIdList.insert(newIndex, item);
    });
    await _playListUseCase.updatePlayList(playList);
  }

  Future addItem(String videoId) async {
    if (playList.videoIdList.contains(videoId)) return;
    _playList.value.videoIdList.add(videoId);
    await _playListUseCase.updatePlayList(playList);
    _playList.refresh();
  }

  Future removeItem(String videoId) async {
    playList.videoIdList.remove(videoId);
    await _playListUseCase.updatePlayList(playList);
  }

  /// playView
  final CarouselControllerImpl pageController = CarouselControllerImpl();

  void refreshCurrentPage(
    bool isPlaying,
    YoutubeDl? currentItem,
  ) {
    if (!isPlaying) {
      pageController.jumpToPage(0);
      return;
    }
    final index = playList.videoIdList
        .indexWhere((element) => element == currentItem!.videoId);
    if (index == -1) return;

    pageController.jumpToPage(index);
  }
}
