import 'package:dio/dio.dart';
import 'package:youtube_dl/enums/download_state.dart';
import 'package:youtube_dl/models/youtube_dl.dart';
typedef ProgressState = Function(DownloadState state,double progress);

abstract class DownRepo {
  Future initRepo();

  List<YoutubeDl> loadDownList();

  Future removeAudio(YoutubeDl dl);

  Future<bool> downloadAudio(YoutubeDl dl, ProgressState progressState);

  Future downloadHeadPhoto(String url, String path);

  void stopDownloadAudio(String videoId);


}
