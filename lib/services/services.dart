import 'package:dio/dio.dart';

abstract class YoutubeConnection {
  final Dio _dio = Dio();

  Future<Response> post(String url, Map<String, dynamic> data) async {
    return await _dio.post(url, queryParameters: data);
  }

  Future<Response> download(
    String uri,
    String savePath, {
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    return await _dio.download(
      uri,
      savePath,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );
  }

  Future<Response> get(
    String url, {
    Map<String, dynamic>? data,
    ProgressCallback? onReceiveProgress,
    Options? options,
  }) async {
    return await _dio.get(
      url,
      queryParameters: data,
      onReceiveProgress: onReceiveProgress,
      options: options,
    );
  }
}
