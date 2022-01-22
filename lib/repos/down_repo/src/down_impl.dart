import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_dl/database/src/down_box.dart';
import 'package:youtube_dl/models/youtube-dl.dart';
import 'package:youtube_dl/repos/down_repo/down_repo.dart';
import 'package:youtube_dl/services/down_service/down_service.dart';
import 'package:youtube_dl/services/firebase_service/firebase_service.dart';

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

  List<YoutubeDl> loadDownList() {
    return _box.loadDownList().map((e) => YoutubeDl.fromMap(e)).toList();
  }

  final Map<String, CancelToken> _tokenMap = {};

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

  @override
  Future downloadAudio(YoutubeDl dl, ProgressCallback onReceiveProgress) async {
    final token = CancelToken();
    _tokenMap[dl.videoId] = token;
    final _path = _dir.path + "/download/${dl.videoId}";
    dl.path = _path;
    dl.headPhotoPath = await downloadHeadPhoto(dl.headPhoto, _path);
    try {
      await _service.downloadAudio(
        dl.videoId,
        _path,
        onReceiveProgress,
        token,
      );
      await _box.updateDown(dl);
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        // print(e.message);
      }
    }
    _tokenMap.remove(dl.videoId);
  }

  @override
  Future<String> downloadHeadPhoto(String url, String path) async {
    final imgPath = path + ".jpeg";
    await _service.download(url, imgPath);
    return imgPath;
  }

  @override
  void stopDownloadAudio(String videoId) {
    if (!_tokenMap.containsKey(videoId)) return;
    _tokenMap[videoId]!.cancel("User Request Cancel");
  }
}
