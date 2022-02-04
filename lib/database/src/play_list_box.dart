import '../local_box.dart';

class PlayListBox extends LocalBox {
  @override
  String get name => "PlayListBox";

  dynamic loadPlayList() {
    return box.get(name);
  }

  Future updatePlayList(Map<String, dynamic> playList) async {
    await box.put(name, playList);
  }
}
