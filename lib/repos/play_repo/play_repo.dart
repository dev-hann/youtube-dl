import 'package:just_audio/just_audio.dart';
import 'package:youtube_dl/models/youtube-dl.dart';

abstract class PlayRepo {
  bool get isPlaying;

  Stream<PlayerState> get playerStateStream;

  Stream<Duration> get positionStream;

  Stream<Duration?> get durationStream;

  Future init();

  Future setYoutubeDl(YoutubeDl dl);

  Future play();

  Future pause();

  Future stop();

  Future seek(int milSec);
}
