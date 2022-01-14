import 'package:dio/dio.dart';

abstract class DownRepo {
  Future initRepo();

  Future audio(String videoId, ProgressCallback onReceiveProgress);
}
