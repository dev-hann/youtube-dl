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
}
