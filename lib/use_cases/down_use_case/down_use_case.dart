import 'package:dio/dio.dart';
import 'package:youtube_dl/enums/download_state.dart';
import 'package:youtube_dl/models/youtube_dl.dart';
import 'package:youtube_dl/repos/down_repo/down_repo.dart';

class DownUseCase {
  DownUseCase(this._repo);

  final DownRepo _repo;

  Future initUseCase() async {
    await _repo.initRepo();
  }

  List<YoutubeDl> loadDownList() {
    return _repo.loadDownList();
  }

  Future<bool> downloadAudio({
    required YoutubeDl dl,
    required ProgressState progressState,
  }) async {
    return await _repo.downloadAudio(dl, progressState);
  }

  void stopDownloadAudio(String videoId) {
    _repo.stopDownloadAudio(videoId);
  }

  Future removeDl(YoutubeDl dl) async {
    await _repo.removeAudio(dl);
  }
}
