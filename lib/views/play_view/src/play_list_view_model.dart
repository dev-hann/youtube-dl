import 'package:youtube_dl/controllers/src/audio_controller.dart';
import 'package:youtube_dl/controllers/src/youtube_controller.dart';
import 'package:youtube_dl/models/play_list.dart';
import 'package:youtube_dl/models/youtube_dl.dart';

class PlayListViewModel {

  final AudioController audioController = AudioController.find();

  YoutubeDl? get currentItem => audioController.currentItem;

  final YoutubeController downController = YoutubeController.find();

  // final PlayListController playListController = PlayListController.find();

  PlayList get playList => audioController.playList;

  List<YoutubeDl> get dlList {
    return downController.findItemList(playList.videoIdList);
  }

  Future<bool> confirmDelete(_) async {
    /// need delete alert to check
    return true;
  }

  void onDelete(int index) async {
    final _item = dlList[index];
    if (audioController.isPlaying) {
      if (audioController.currentItem == _item) {
        await audioController.stop();
        audioController.clearCurrentDl();
      }
    }
    await audioController.removeItem(_item.videoId);
    await downController.removeItem(_item);
  }

  Future<void> onReorder(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = dlList.removeAt(oldIndex);
    dlList.insert(newIndex, item);
    await audioController.reorderPlayList(oldIndex, newIndex);
    audioController.refreshCurrentPage(
      audioController.isPlaying,
      audioController.currentItem,
    );
  }

  void onTapItem(YoutubeDl dl) async {
    await audioController.setYoutubeDl(dl);
    await audioController.play();
  }
}
