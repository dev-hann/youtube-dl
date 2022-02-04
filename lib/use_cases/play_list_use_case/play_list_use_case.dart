import 'package:youtube_dl/models/play_list.dart';
import 'package:youtube_dl/repos/play_list_repo/play_list_repo.dart';

class PlayListUseCase {
  PlayListUseCase(this.repo);

  final PlayListRepo repo;

  Future initUseCase() async {
    await repo.initRepo();
  }

  PlayList loadPlayList() {
    final _res = repo.loadPlayList();
    if (_res == null) return PlayList(index: 0, title: "PlayList");
    return PlayList.fromMap(_res);
  }

  Future updatePlayList(PlayList playList)async{
    await repo.updatePlayList(playList.toMap());
  }

}
