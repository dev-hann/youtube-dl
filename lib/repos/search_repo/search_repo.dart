import 'package:dio/dio.dart';

abstract class SearchRepo {
  Future<Response> searchAudio(String query);
  Future<Response> videosDuration(List<String> videoIds);
}
