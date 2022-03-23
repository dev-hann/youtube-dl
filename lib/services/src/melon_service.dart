import 'package:youtube_dl/models/download_response.dart';
import 'package:youtube_dl/services/services.dart';

class MelonService extends YoutubeConnection {
  MelonService(String baseURL) : baseURL = baseURL + "/v1/melon";

  final String baseURL;

  Future<DownloadResponse> loadMelon()async{
    return ;
  }


}
