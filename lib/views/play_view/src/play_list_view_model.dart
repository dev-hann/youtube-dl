import 'package:youtube_dl/controllers/src/down_controller.dart';
import 'package:youtube_dl/controllers/src/play_controller.dart';
import 'package:youtube_dl/models/youtube-dl.dart';

class PlayListViewModel {
  final DownController downController = DownController.find();
  final PlayController playController = PlayController.find();

  List<YoutubeDl> get dlList => downController.dlList;

  void onTapItem(YoutubeDl dl) async {
    await playController.setYoutubeDl(dl);
    await playController.play();
  }



}
