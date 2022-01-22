import 'package:youtube_dl/models/youtube-dl.dart';
import 'package:youtube_dl/repos/play_repo/play_repo.dart';

class PlayUseCase {
  PlayUseCase(this._repo);

  final PlayRepo _repo;

  get isPlaying => _repo.isPlaying;

  Future init({
    Function(int current, int total)? durationListener,
  }) async {
    await _repo.init(durationListener: durationListener);
  }

  Future play() async {
    await _repo.play();
  }

  Future pause() async {
    await _repo.pause();
  }

  Future stop() async {
    await _repo.stop();
  }

  Future seek(int milSec) async {
    await _repo.seek(milSec);
  }

  Future setYoutubeDl(YoutubeDl dl) async {
    await _repo.setYoutubeDl(dl);
  }
}
