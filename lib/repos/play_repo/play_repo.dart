import 'package:just_audio/just_audio.dart';
import 'package:youtube_dl/models/play_list.dart';
import 'package:youtube_dl/models/youtube_dl.dart';

abstract class PlayRepo {
  bool get isPlaying;

  Stream<PlayerState> get playerStateStream;

  Stream<Duration> get positionStream;

  Stream<Duration?> get durationStream;

  Future initPlayer();

  Future setYoutubeDl(YoutubeDl dl);

  Future play();

  Future pause();

  Future stop();

  Future seek(int milSec);

  /// playList
  Future initPlayList();

  List<PlayList> loadPlayList();

  Future updatePlayList(PlayList playList);

}
