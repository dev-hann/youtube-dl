import 'package:just_audio/just_audio.dart';
import 'package:youtube_dl/models/youtube-dl.dart';

abstract class PlayRepo {
  Future init(
      {
        Function(int current, int total)? durationListener,
      }
  );

  Future play([YoutubeDl? dl]);

  Future pause();

  Future stop();

  Future seek(int milSec);
}
