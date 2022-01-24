import 'dart:async';

import 'package:just_audio/just_audio.dart';
import 'package:youtube_dl/database/src/down_box.dart';
import 'package:youtube_dl/models/youtube-dl.dart';
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
  Future init() async {
    await _box.openBox();
    _handler = await initAudioHandler();
    await _handler.prepare();
  }

  @override
  Future setYoutubeDl(YoutubeDl dl) async {
    await _handler.addQueueItem(dl.toMediaItem);
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
}
