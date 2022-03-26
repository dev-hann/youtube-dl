import 'package:youtube_dl/enums/download_state.dart';

class DlSnapshot {
  DlSnapshot({
    this.state = DownloadState.none,
    this.progress = 0,
  });

  DownloadState state;
  double progress;

  factory DlSnapshot.none(){
    return DlSnapshot(state: DownloadState.none,progress: 0);
  }

  factory DlSnapshot.done(){
    return DlSnapshot(state: DownloadState.done,progress: 1);
  }

  Map<String, dynamic> toMap() {
    return {
      'state': state,
      'progress': progress,
    };
  }

  factory DlSnapshot.fromMap(Map<String, dynamic> map) {
    return DlSnapshot(
      state: map['state'] as DownloadState,
      progress: map['progress'] as double,
    );
  }
}
