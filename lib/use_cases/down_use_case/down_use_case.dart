import 'package:dio/dio.dart';
import 'package:youtube_dl/repos/down_repo/down_repo.dart';

class DownUseCase {
  DownUseCase(this._repo);

  final DownRepo _repo;

  Future initUseCase() async {
    await _repo.initRepo();
  }

  Future downloadAudio(String videoId,
      ProgressCallback onReceiveProgress) async {
    await _repo.audio(videoId, onReceiveProgress);
  }
}