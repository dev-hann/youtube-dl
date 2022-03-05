import 'package:just_audio/just_audio.dart';
import 'package:youtube_dl/enums/play_repeat_state.dart';
import 'package:youtube_dl/models/youtube_dl.dart';

abstract class PlayRepo {
  bool get isPlaying;

  Stream<PlayerState> get playerStateStream;

  Stream<Duration> get positionStream;

  Stream<Duration?> get durationStream;

  Future initPlayer();

  Future setPlayList(List<String> videoIdList);

  Future setPlayItem(YoutubeDl dl);

  Future play();

  Future pause();

  Future stop();

  Future seek(int milSec);

  Future setRepeatMode(PlayRepeatState repeatState);
}
