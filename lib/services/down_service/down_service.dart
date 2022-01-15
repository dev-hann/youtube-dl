import 'package:dio/dio.dart';
import 'package:youtube_dl/models/down_result.dart';
import 'package:youtube_dl/services/services.dart';

class DownService extends YoutubeConnection {
  DownService(this.baseURL);

  final String baseURL;

  String _getAudioURL(String videoId) {
    return baseURL + "/audio/$videoId";
  }

  Future<Response> audio(
      String videoId, ProgressCallback onReceiveProgress) async {
    final Response _res = await get(_getAudioURL(videoId));
    final _downObj = DownResult.fromMap(_res);
    if (!_downObj.result) {
      print("error => ${_downObj.data}");
    }
    return await get(_res.data, onReceiveProgress: onReceiveProgress);
  }
}
