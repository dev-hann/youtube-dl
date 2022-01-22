import 'package:just_audio/just_audio.dart';
import 'package:youtube_dl/models/youtube-dl.dart';

abstract class PlayRepo {
  get isPlaying;

  Future init({
    Function(int current, int total)? durationListener,
  });
  Future setYoutubeDl(YoutubeDl dl);

  Future play();

  Future pause();

  Future stop();

  Future seek(int milSec);

}
