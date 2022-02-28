import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_dl/database/src/down_box.dart';
import 'package:youtube_dl/enums/download_state.dart';
import 'package:youtube_dl/models/youtube_dl.dart';
import 'package:youtube_dl/repos/down_repo/down_repo.dart';
import 'package:youtube_dl/services/src/down_service.dart';
import 'package:youtube_dl/services/src/firebase_service.dart';

class DownImpl extends DownRepo {
  final FirebaseService _firebaseService = FirebaseService();
  final DownBox _box = DownBox();

  late DownService _service;
  late Directory _dir;

  @override
  Future initRepo() async {
    await _initService();
    await _initLocalBox();
  }

  Future _initService() async {
    final _fireResult = await _firebaseService.init();
    if (_fireResult == null) return;
    _dir = await getApplicationDocumentsDirectory();

    _service = DownService(
      _fireResult.tunnels
          .firstWhere((element) => element.proto == "https")
          .publicUrl,
    );
  }

  Future _initLocalBox() async {
    await _box.openBox();
  }

  @override
  List<YoutubeDl> loadDownList() {
    return _box.loadDownList().map((e) => YoutubeDl.fromMap(e)).toList();
  }

  @override
  Future removeAudio(YoutubeDl dl) async {
    await _box.removeDown(dl.videoId);
    await _removeFile(dl.path);
    await _removeFile(dl.headPhotoPath);
  }

  Future _removeFile(String? path) async {
    if (path == null) return;
    final _file = File(path);
    final exist = await _file.exists();
    if (!exist) return;
    _file.deleteSync();
  }

  /// Cancel Token
  final Map<String, CancelToken> _cancelTokenMap = {};

  CancelToken updateNewToken(String videoId) {
    final token = CancelToken();
    _cancelTokenMap[videoId] = token;
    return token;
  }

  void removeCancelToken(String videoId) {
    _cancelTokenMap.remove(videoId);
  }

  @override
  void stopDownloadAudio(String videoId) {
    if (!_cancelTokenMap.containsKey(videoId)) return;
    _cancelTokenMap[videoId]!.cancel("User Request Cancel");
  }

  @override
  Future<bool> downloadAudio(YoutubeDl dl, ProgressState progressState) async {
    final videoId = dl.videoId;
    final token = updateNewToken(dl.videoId);

    final _path = _dir.path + "/download/${videoId}";
    dl.path = _path;
    progressState(DownloadState.loadHeadPhoto, 0);
    dl.headPhotoPath = await downloadHeadPhoto(dl.headPhotoHQ, _path);
    progressState(DownloadState.loadRawURL, 0);
    final rawURL = await _service.youtubeRawURL(videoId);

    try {
      progressState(DownloadState.loadAudio, 0);
      await _service.downloadAudio(
        rawURL,
        _path,
        (current, total) {
          progressState(DownloadState.loadAudio, current / total);
        },
        token,
      );
      await _box.updateDown(dl);
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        // print(e.message);
      }
      return false;
    }
    removeCancelToken(videoId);
    progressState(DownloadState.done, 1);
    return true;
  }

  @override
  Future<String> downloadHeadPhoto(String url, String path) async {
    final imgPath = path + ".jpeg";
    await _service.download(url, imgPath);
    return imgPath;
  }
}
