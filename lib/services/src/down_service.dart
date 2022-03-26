import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:youtube_dl/models/dl_response.dart';
import 'package:youtube_dl/services/services.dart';

class DownService extends YoutubeConnection {
  DownService(this.baseURL);

  final String baseURL;

  String _getAudioURL(String videoId) {
    return baseURL + "/v1/audio/$videoId";
  }
  ///fix here!! to divide each process
  Future<DlResponse> youtubeRawURL(String videoId) async {
    final _address = _getAudioURL(videoId);
    final res = await get(_address);
    return DlResponse.fromMap(jsonDecode(res.data));
  }

  Future<Response> downloadAudio(
    DlResponse response,
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
