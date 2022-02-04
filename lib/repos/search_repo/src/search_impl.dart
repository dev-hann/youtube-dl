import 'package:dio/dio.dart';
import 'package:youtube_dl/services/search_service/search_service.dart';

import '../search_repo.dart';

class SearchImpl extends SearchRepo {
  final SearchServices services = SearchServices();

  @override
  Future<Response> searchAudio(String query) async {
    return await services.searchAudio(query);
  }

  @override
  Future<Response> videosDuration(List<String> videoIds)async{
    return await services.videosDuration(videoIds);
  }

}
