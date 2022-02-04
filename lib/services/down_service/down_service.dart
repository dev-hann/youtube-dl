import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:youtube_dl/models/download_response.dart';
import 'package:youtube_dl/services/services.dart';

class DownService extends YoutubeConnection {
  DownService(this.baseURL);

  final String baseURL;

  String _getAudioURL(String videoId) {
    return baseURL + "/audio/$videoId";
  }
  ///fix here!! to divide each process
  Future<DownloadResponse> youtubeRawURL(String videoId) async {
    final _address = _getAudioURL(videoId);
    final res = await get(_address);
    return DownloadResponse.fromMap(jsonDecode(res.data));
  }

  Future<Response> downloadAudio(
    DownloadResponse response,
    String savePath,
    ProgressCallback onReceiveProgress,
    CancelToken cancelToken,
  ) async {
    if (!response.result) {
      print("error => ${response.data}");
    }
    return await download(
      response.data,
      savePath,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );
  }
}
