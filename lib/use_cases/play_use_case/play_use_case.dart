import 'package:just_audio/just_audio.dart';
import 'package:youtube_dl/models/play_list.dart';
import 'package:youtube_dl/models/youtube_dl.dart';
import 'package:youtube_dl/repos/play_repo/play_repo.dart';

class PlayUseCase {
  PlayUseCase(this._repo);

  final PlayRepo _repo;

  bool get isPlaying => _repo.isPlaying;

  Stream<PlayerState> get playerStateStream => _repo.playerStateStream;

  Stream<Duration> get positionStream => _repo.positionStream;

  Stream<Duration?> get durationStream => _repo.durationStream;

  Future init() async {
    await _repo.initPlayer();
    await _repo.initPlayList();
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

  /// playList
  List<PlayList> loadPlayList() {
    return _repo.loadPlayList();
  }

  Future updatePlayList(PlayList playList) async {
    await _repo.updatePlayList(playList);
  }
}
