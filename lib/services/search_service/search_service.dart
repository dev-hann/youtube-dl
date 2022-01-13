import '../services.dart';

const String apiKey = "AIzaSyB6QkWdSPm2oYdsBwA5YyaPCKBWIMvCb5g";
const String baseURL = 'www.googleapis.com';

class SearchServices extends YoutubeConnection {
  final _searchURL = "/youtube/v3/search";

  Future searchAudio(String query) async {
    final _data = {
      "key": apiKey,
      "q": query,
      "part": "snippet",
      "type": "video",
      "maxResults": 20,
    };
    final _res = await get(baseURL + _searchURL, data: _data);
    print(_res);
  }
}
