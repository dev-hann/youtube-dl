import 'package:dio/dio.dart';
import 'package:youtube_dl/models/youtube-dl.dart';

abstract class DownRepo {
  Future initRepo();

  List<YoutubeDl> loadDownList();

  Future removeAudio(YoutubeDl dl);

  Future downloadAudio(YoutubeDl dl, ProgressCallback onReceiveProgress);

  Future downloadHeadPhoto(String url, String path);

  void stopDownloadAudio(String videoId);


}
