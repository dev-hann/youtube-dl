class PlayList {
  PlayList({
    required this.index,
    String? title,
    List<String>? videoIdList,
  })  : title = title ?? "",
        videoIdList = videoIdList ?? [];

  final int index;
  String title;
  final List<String> videoIdList;

  Map<String, dynamic> toMap() {
    return {
      'index': this.index,
      'title': this.title,
      'videoIdList': this.videoIdList,
    };
  }

  factory PlayList.fromMap(dynamic _map) {
    Map<String, dynamic> map = Map<String, dynamic>.from(_map);
    return PlayList(
      index: map['index'] as int,
      title: map['title'] as String,
      videoIdList: map['videoIdList'] as List<String>,
    );
  }
}
