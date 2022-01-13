import 'package:dio/dio.dart';

abstract class YoutubeConnection {
  final Dio _dio = Dio();

  Future<Response> post(String url, Map<String, dynamic> data) async {
    return await _dio.post(url, queryParameters: data);
  }

  Future<Response> get(String url, {Map<String, dynamic>? data}) async {
    return await _dio.get(url, queryParameters: data);
  }
}
