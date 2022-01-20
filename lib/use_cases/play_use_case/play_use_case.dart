import 'package:just_audio/just_audio.dart';
import 'package:youtube_dl/models/youtube-dl.dart';
import 'package:youtube_dl/repos/play_repo/play_repo.dart';

class PlayUseCase {
  PlayUseCase(this._repo);

  final PlayRepo _repo;

  Future init() async {
    await _repo.init();
  }

  Future play([YoutubeDl? dl]) async {
    await _repo.play(dl);
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
}
