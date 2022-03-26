import 'package:youtube_dl/models/dl_response.dart';
import 'package:youtube_dl/services/services.dart';

class MelonService extends YoutubeConnection {
  MelonService(String baseURL) : baseURL = baseURL + "/v1/melon";

  final String baseURL;

  Future<DlResponse> loadMelonChart() async {
    final _res = await get(baseURL);
    return DlResponse.fromMap(_res);
  }
}
