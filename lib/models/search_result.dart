class SearchResult {
  const SearchResult({
    required this.nextPageToken,
    required this.items,
  });

  final String nextPageToken;
  final List<ResultItem> items;

  Map<String, dynamic> toMap() {
    return {
      'nextPageToken': nextPageToken,
      'items': items.map((e) => e.toMap()).toList(),
    };
  }

  factory SearchResult.fromMap(Map<String, dynamic> map) {
    return SearchResult(
      nextPageToken: map['nextPageToken'] as String,
      items: (map['items'] as List).map((e) => ResultItem.fromMap(e)).toList(),
    );
  }
}

class ResultItem {
  ResultItem({
    required this.videoId,
    required this.publishedAt,
    required this.title,
    required this.description,
  });

  final String videoId;
  final DateTime publishedAt;
  final String title;
  final String description;

  Map<String, dynamic> toMap() {
    return {
      'videoId': videoId,
      'publishedAt': publishedAt,
      'title': title,
      'description': description,
    };
  }

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
