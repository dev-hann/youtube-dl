class YoutubeDl{
  const YoutubeDl({
    required this.videoId,
    required this.title,
  });

  final String videoId;
  final String title;
  Map<String, dynamic> toMap() {
    return {
      'videoId': videoId,
      'title':title,
    };
  }

  factory YoutubeDl.fromMap(Map<String, dynamic> map) {
    return YoutubeDl(
      videoId: map['videoId'] as String,
      title: map['title'],
    );
  }
}