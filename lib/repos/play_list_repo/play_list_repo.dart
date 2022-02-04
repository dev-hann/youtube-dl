abstract class PlayListRepo {
  Future initRepo();

  dynamic loadPlayList();

  Future updatePlayList(Map<String, dynamic> playList);

}
