import 'package:just_audio/just_audio.dart';
import 'package:youtube_dl/repos/play_repo/play_repo.dart';

class PlayUseCase {
  PlayUseCase(this._repo);

  final PlayRepo _repo;

  Future init(
    String path,
    Function(PlayerState state)? onChangedState,
    Function(int current, int total)? onChangedDuration,
  ) async {
    await _repo.init(
      path,
      onChangedState,
      onChangedDuration,
    );
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
}
