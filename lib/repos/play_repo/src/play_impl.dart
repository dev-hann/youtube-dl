import 'dart:async';

import 'package:just_audio/just_audio.dart';
import 'package:youtube_dl/repos/play_repo/play_repo.dart';

class PlayImpl extends PlayRepo {
  final _player = AudioPlayer();

  bool get isPlaying => _player.playing;

  @override
  Future init(
    String path,
    Function(PlayerState state)? onChangedState,
    Function(int current, int total)? onChangedDuration,
  ) async {
    await _player.setFilePath(path);
    _stateListener(onChangedState);
    _durationListener(onChangedDuration);
  }

  StreamSubscription? _stateSub;

  void _stateListener(Function(PlayerState state)? onData) {
    if (_stateSub != null) {
      _stateSub!.cancel();
    }
    _stateSub = _player.playerStateStream.listen(onData);
  }

  StreamSubscription? _durationSub;

  void _durationListener(Function(int current, int total)? onData) {
    if (_durationSub != null) {
      _durationSub!.cancel();
    }
    _durationSub = _player.createPositionStream().listen((event) {
      if (event.inMilliseconds == _player.duration!.inMilliseconds) {
        stop();
      }
      onData!(event.inMilliseconds, _player.duration!.inMilliseconds);
    });
  }

  @override
  Future play() async {
    if (isPlaying) return;
    await _player.play();
  }

  @override
  Future pause() async {
    if (!isPlaying) return null;
    await _player.pause();
  }

  @override
  Future stop() async {
    if (!isPlaying) return null;
    _player.stop();
  }

  @override
  Future seek(int milSec) async {
    await _player.seek(Duration(milliseconds: milSec));
  }
}
