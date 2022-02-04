import 'package:youtube_dl/database/src/play_list_box.dart';
import 'package:youtube_dl/repos/play_list_repo/play_list_repo.dart';

/// Future : PlayList can be more Thing.
class PlayListImpl extends PlayListRepo {
  final PlayListBox box = PlayListBox();

  @override
  Future initRepo() async {
    await box.openBox();
    // await box.clearBox();
  }

  @override
  dynamic loadPlayList() {
    return box.loadPlayList();
  }

  @override
  Future updatePlayList(Map<String,dynamic> playList) async {
    await box.updatePlayList(playList);
  }

}
