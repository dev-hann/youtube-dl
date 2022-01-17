import 'package:dio/dio.dart';
import 'package:youtube_dl/services/services.dart';

class DownService extends YoutubeConnection {
  DownService(this.baseURL);

  final String baseURL;

  String _getAudioURL(String videoId) {
    return baseURL + "/audio/$videoId";
  }

  Future<Response> downloadAudio(
    String videoId,
    String savePath,
    ProgressCallback onReceiveProgress,
    CancelToken cancelToken,
  ) async {
    // final Response _res = await get(_getAudioURL(videoId));
    // final _downObj = DownResult.fromMap(_res);
    // if (!_downObj.result) {
    //   print("error => ${_downObj.data}");
    // }
    const _test =
        "https://cdn.simplecast.com/audio/d908c540-1607-45ea-89a0-ab43f5641e6c/episodes/625271f9-72a2-4837-8a7f-b3c9212e28ef/audio/3b40a94c-eee1-4980-b2e6-e5078e520fd3/default_tc.mp3?aid=rss_feed&feed=58sckhh4";
    return await download(
      _test,
      savePath,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );
  }
}
