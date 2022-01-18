import 'package:just_audio/just_audio.dart';
import 'package:youtube_dl/repos/play_repo/play_repo.dart';

class PlayImpl extends PlayRepo {
  final _player = AudioPlayer();

  bool get isPlaying => _player.playing;

  @override
  Future init(String path) async {
    final _duration = await _player.setFilePath(path);
    print(_duration);
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
}
