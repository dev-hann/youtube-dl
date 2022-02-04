import 'package:youtube_dl/enums/download_state.dart';

class DownloadSnapshot {
  DownloadSnapshot({
    this.state = DownloadState.none,
    this.progress = 0,
  });

  DownloadState state;
  double progress;

  factory DownloadSnapshot.none(){
    return DownloadSnapshot(state: DownloadState.none,progress: 0);
  }

  factory DownloadSnapshot.done(){
    return DownloadSnapshot(state: DownloadState.done,progress: 1);
  }

  Map<String, dynamic> toMap() {
    return {
      'state': state,
      'progress': progress,
    };
  }

  factory DownloadSnapshot.fromMap(Map<String, dynamic> map) {
    return DownloadSnapshot(
      state: map['state'] as DownloadState,
      progress: map['progress'] as double,
    );
  }
}
