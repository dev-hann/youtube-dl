import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_dl/models/youtube-dl.dart';
import 'package:youtube_dl/repos/down_repo/down_repo.dart';
import 'package:youtube_dl/services/down_service/down_service.dart';
import 'package:youtube_dl/services/firebase_service/firebase_service.dart';

class DownImpl extends DownRepo {
  final FirebaseService _firebaseService = FirebaseService();
  late DownService _service;
  late Directory _dir;

  @override
  Future initRepo() async {
    final _fireResult = await _firebaseService.init();
    if (_fireResult == null) return;
    _dir = await getApplicationDocumentsDirectory();

    _service = DownService(
      _fireResult.tunnels
          .firstWhere((element) => element.proto == "https")
          .publicUrl,
    );
  }

  final Map<String, CancelToken> _tokenMap = {};

  @override
  Future downloadAudio(YoutubeDl dl, ProgressCallback onReceiveProgress) async {
    final token = CancelToken();
    _tokenMap[dl.videoId] = token;
    final _path = _dir.path + "/download/${dl.videoId}";
    dl.path = _path;
    try {
      await _service.downloadAudio(
        dl.videoId,
        _path,
        onReceiveProgress,
        token,
      );
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print(e.message);
      }
    }
    _tokenMap.remove(dl.videoId);
  }

  @override
  void stopDownloadAudio(String videoId) {
    if (!_tokenMap.containsKey(videoId)) return;
    _tokenMap[videoId]!.cancel("User Request Cancel");
  }
}
