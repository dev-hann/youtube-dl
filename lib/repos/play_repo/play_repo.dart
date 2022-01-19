import 'package:just_audio/just_audio.dart';

abstract class PlayRepo {
  Future init(
    String path,
    Function(PlayerState state)? onChangedState,
    Function(int current, int total)? onChangedDuration,
  );

  Future play();

  Future pause();

  Future stop();

  Future seek(int milSec);
}
