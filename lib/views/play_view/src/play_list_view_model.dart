import 'package:get/get.dart';
import 'package:youtube_dl/controllers/src/down_controller.dart';
import 'package:youtube_dl/controllers/src/play_controller.dart';
import 'package:youtube_dl/models/play_list.dart';
import 'package:youtube_dl/models/youtube_dl.dart';

class PlayListViewModel {
  PlayListViewModel() {
    _init();
  }

  final PlayController playController = PlayController.find();
  final DownController downController = DownController.find();

  List<PlayList> get playList => playController.pLayList;
  late Rx<PlayList> currentPlayList;
  List<YoutubeDl> selectedList = <YoutubeDl>[].obs;

  void _init() {
    selectedList(downController.findItemList(playList.first.videoIdList));
  }

  void onTapItem(YoutubeDl dl) async {
    await playController.setYoutubeDl(dl);
    await playController.play();
  }

  void onDelete(_) {
    print("!!");
  }

  Future<bool> confirmDelete(_) async {
    return false;
  }
}
