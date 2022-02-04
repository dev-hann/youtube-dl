import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:youtube_dl/database/src/down_box.dart';
import 'package:youtube_dl/database/src/play_list_box.dart';
import 'package:youtube_dl/enums/play_repeat_state.dart';
import 'package:youtube_dl/models/play_list.dart';
import 'package:youtube_dl/models/youtube_dl.dart';
import 'package:youtube_dl/repos/play_repo/play_repo.dart';
import 'package:youtube_dl/utils/audio_handler.dart';

class PlayImpl extends PlayRepo {
  late YoutubeAudioHandler _handler;
  final DownBox _box = DownBox();

  @override
  bool get isPlaying => _handler.isPlaying;

  @override
  Stream<PlayerState> get playerStateStream => _handler.playerStateStream;

  @override
  Stream<Duration> get positionStream => _handler.positionStream;

  @override
  Stream<Duration?> get durationStream => _handler.durationStream;

  @override
  Future initPlayer() async {
    await _box.openBox();
    _handler = await initAudioHandler();
    await _handler.prepare();
  }

  @override
  Future setPlayList(List<String> videoIdList) async {
    final _list = _box.loadDownList().map((e) => YoutubeDl.fromMap(e)).toList();
    final _res = <MediaItem>[];
    for (final id in videoIdList) {
      final index = _list.indexWhere((element) => element.videoId == id);
      if (index == -1) continue;
      _res.add(_list[index].mediaItem);
    }
    await _handler.addQueueItems(_res);
  }

  @override
  Future play() async {
    await _handler.play();
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
    await _handler.seek(Duration(milliseconds: milSec));
  }

  @override
  Future setRepeatMode(PlayRepeatState repeatState) async {
    await _handler
        .setRepeatMode(AudioServiceRepeatMode.values[repeatState.index]);
  }
}
