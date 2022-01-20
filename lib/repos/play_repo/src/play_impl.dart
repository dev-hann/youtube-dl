import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:youtube_dl/database/src/down_box.dart';
import 'package:youtube_dl/models/youtube-dl.dart';
import 'package:youtube_dl/repos/play_repo/play_repo.dart';
import 'package:youtube_dl/utils/audio_handler.dart';

class PlayImpl extends PlayRepo {
  late YoutubeAudioHandler _handler;
  final DownBox _box = DownBox();

  bool get isPlaying => _handler.isPlaying;

  @override
  Future init() async {
    await _box.openBox();

    final List<MediaItem> itemList = _box
        .loadDownList()
        .map((e) => YoutubeDl.fromMap(e).toMediaItem)
        .toList();

    _handler = await initAudioHandler(itemList);
    await _handler.prepare();
    await _handler.addQueueItems(itemList);
  }

  StreamSubscription? _stateSub;

  void _stateListener(Function(PlayerState state)? onData) {
    if (_stateSub != null) {
      _stateSub!.cancel();
    }
    // _stateSub = _player.playerStateStream.listen(onData);
  }

  StreamSubscription? _durationSub;

  void _durationListener(Function(int current, int total)? onData) {
    if (_durationSub != null) {
      _durationSub!.cancel();
    }
    // _durationSub = _player.createPositionStream().listen((event) {
    //   if (event.inMilliseconds == _player.duration!.inMilliseconds) {
    //     stop();
    //   }
    //   onData!(event.inMilliseconds, _player.duration!.inMilliseconds);
    // });
  }

  @override
  Future play([YoutubeDl? dl]) async {
    if (dl == null) {
      await _handler.play();
    } else {
      await _handler.playMediaItem(dl.toMediaItem);
    }
  }

  @override
  Future pause() async {
    _handler.pause();
  }

  @override
  Future stop() async {
    _handler.stop();
  }

  @override
  Future seek(int milSec) async {
    // await _player.seek(Duration(milliseconds: milSec));
  }
}
