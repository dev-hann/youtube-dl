import 'package:youtube_dl/database/local_box.dart';
import 'package:youtube_dl/models/youtube-dl.dart';

class DownBox extends LocalBox {
  @override
  String get name => "DownBox";

  List loadDownList() {
    return box.values.toList();
  }

  Future updateDown(YoutubeDl dl) async {
    await box.put(dl.videoId, dl.toMap());
  }

  Future removeDown(String videoId) async {
    await box.delete(videoId);
  }
}
