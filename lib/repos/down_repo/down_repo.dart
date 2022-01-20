import 'package:dio/dio.dart';
import 'package:youtube_dl/models/youtube-dl.dart';

abstract class DownRepo {
  Future initRepo();

  List<YoutubeDl> loadDownList();

  Future downloadAudio(YoutubeDl dl, ProgressCallback onReceiveProgress);

  void stopDownloadAudio(String videoId);
}
