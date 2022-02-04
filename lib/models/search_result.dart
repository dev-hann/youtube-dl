import 'package:youtube_dl/models/youtube_dl.dart';
import 'package:youtube_dl/utils/iso_parser.dart';

import 'youtube.dart';

class SearchResult {
  const SearchResult({
    required this.nextPageToken,
    required this.items,
  });

  final String nextPageToken;
  final List<ResultItem> items;

  List<String> get videoIdList => items.map((e) => e.videoId).toList();

  int _indexWhere(String videoId) {
    return videoIdList.indexWhere((element) => element == videoId);
  }

  Map<String, dynamic> toMap() {
    return {
      'nextPageToken': nextPageToken,
      'items': items.map((e) => e.toMap()).toList(),
    };
  }

  void setDurationList(dynamic _map) {
    Map<String, dynamic> map = Map<String, dynamic>.from(_map);
    final List<dynamic> durationItems = map['items'];
    for (final durationItem in durationItems) {
      final durationItemId = durationItem["id"];
      final durationStr = durationItem["contentDetails"]["duration"];
      final index = _indexWhere(durationItemId);
      if (index == -1) continue;
      final item = items[index];
      item.duration = Duration(
        seconds: IsoDuration.parse(durationStr).toSeconds().toInt(),
      );
      items[index] = item;
    }
  }

  factory SearchResult.fromMap(Map<String, dynamic> map) {
    return SearchResult(
      nextPageToken: map['nextPageToken'] as String,
      items: (map['items'] as List).map((e) => ResultItem.fromMap(e)).toList(),
    );
  }
}

class ResultItem extends Youtube {
  ResultItem({
    required String videoId,
    required DateTime publishedAt,
    required String title,
    required String description,
  }) : super(
          videoId: videoId,
          publishedAt: publishedAt,
          title: title,
          description: description,
        );

  factory ResultItem.fromMap(dynamic _map) {
    Map<String, dynamic> map = Map<String, dynamic>.from(_map);
    return ResultItem(
      videoId: map['id']['videoId'] as String,
      publishedAt: DateTime.parse(map['snippet']['publishedAt']),
      title: map['snippet']['title'] as String,
      description: map['snippet']['description'] as String,
    );
  }
}

extension ItemMapper on ResultItem {
  YoutubeDl get toYoutubeDl {
    return YoutubeDl(
      videoId: videoId,
      publishedAt: publishedAt,
      title: title,
      description: description,
      duration: duration,
    );
  }
}
