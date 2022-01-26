
import '../local_box.dart';

class PlayListBox extends LocalBox {
  @override
  String get name => "PlayListBox";

  List loadPlayList() {
    return box.values.toList();
  }

  Future updatePlayList(
    int playListIndex,
    Map<String, dynamic> playList,
  ) async {
    box.put(playListIndex, playList);
  }
}
