import 'package:youtube_dl/controllers/src/download_controller.dart';
import 'package:youtube_dl/controllers/src/play_controller.dart';
import 'package:youtube_dl/controllers/src/play_list_controller.dart';
import 'package:youtube_dl/models/play_list.dart';
import 'package:youtube_dl/models/youtube_dl.dart';

class PlayListViewModel {

  final PlayController playController = PlayController.find();

  YoutubeDl? get currentItem => playController.currentItem;

  final DownloadController downController = DownloadController.find();

  // final PlayListController playListController = PlayListController.find();

  PlayList get playList => playController.playList;

  List<YoutubeDl> get dlList {
    return downController.findItemList(playList.videoIdList);
  }

  Future<bool> confirmDelete(_) async {
    /// need delete alert to check
    return true;
  }

  void onDelete(int index) async {
    final _item = dlList[index];
    if (playController.isPlaying) {
      if (playController.currentItem == _item) {
        await playController.stop();
        playController.clearCurrentDl();
      }
    }
    await playController.removeItem(_item.videoId);
    await downController.removeItem(_item);
  }

  Future<void> onReorder(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = dlList.removeAt(oldIndex);
    dlList.insert(newIndex, item);
    await playController.reorderPlayList(oldIndex, newIndex);
    playController.refreshCurrentPage(
      playController.isPlaying,
      playController.currentItem,
    );
  }

  void onTapItem(YoutubeDl dl) async {
    await playController.setYoutubeDl(dl);
    await playController.play();
  }
}
