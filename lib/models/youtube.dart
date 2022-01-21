abstract class Youtube {
  Youtube({
    required this.videoId,
    required this.publishedAt,
    required this.title,
    required this.description,
  });

  final String videoId;
  final DateTime publishedAt;
  final String title;
  final String description;

  String get headPhoto => "https://img.youtube.com/vi/$videoId/default.jpg";

  Map<String, dynamic> toMap() {
    return {
      'videoId': videoId,
      'publishedAt': publishedAt,
      'title': title,
      'description': description,
    };
  }
}
