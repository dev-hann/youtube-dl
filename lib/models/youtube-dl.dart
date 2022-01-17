class YoutubeDl {
  YoutubeDl({
    required this.videoId,
    this.title,
    this.path,
  });

  final String videoId;
  String? title;
  String? path;

  Map<String, dynamic> toMap() {
    return {
      'videoId': videoId,
      'title': title,
      'path': path,
    };
  }

  factory YoutubeDl.fromMap(Map<String, dynamic> map) {
    return YoutubeDl(
      videoId: map['videoId'] as String,
      title: map['title'],
      path: map['path'],
    );
  }
}
