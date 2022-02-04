abstract class Youtube {
  Youtube({
    required this.videoId,
    required this.publishedAt,
    required this.title,
    required this.description,
    Duration? duration,
  }) : duration = duration ?? Duration.zero;

  final String videoId;
  final DateTime publishedAt;
  final String title;
  final String description;
  Duration duration;

  String get headPhoto => "https://img.youtube.com/vi/$videoId/default.jpg";

  String get headPhotoHQ => "https://img.youtube.com/vi/$videoId/hqdefault.jpg";

  Map<String, dynamic> toMap() {
    return {
      'videoId': videoId,
      'publishedAt': publishedAt,
      'title': title,
      'description': description,
      'duration': duration.inSeconds
    };
  }
}
