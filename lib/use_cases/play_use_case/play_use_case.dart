import 'package:youtube_dl/repos/play_repo/play_repo.dart';

class PlayUseCase {
  PlayUseCase(this._repo);

  final PlayRepo _repo;

  Future init(String path) async {
    await _repo.init(path);
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
}
