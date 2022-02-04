enum DownloadState {
  none,
  loadHeadPhoto,
  loadRawURL,
  loadAudio,
  done,
}

extension DownloadStateExtension on DownloadState {
  bool get isNone => index == 0;

  bool get isLoadHeadPhoto => index == 1;

  bool get isLoadRawURL => index == 2;

  bool get isLoadAudio => index == 3;

  bool get isDone => index == 4;
}
