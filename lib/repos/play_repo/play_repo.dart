import 'package:just_audio/just_audio.dart';
import 'package:youtube_dl/models/youtube-dl.dart';

abstract class PlayRepo {
  Future init(
    // List<YoutubeDl> dlList,
    // Function(PlayerState state)? onChangedState,
    // Function(int current, int total)? onChangedDuration,
  );

  Future play([YoutubeDl? dl]);

  Future pause();

  Future stop();

  Future seek(int milSec);
}
