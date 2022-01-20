import 'package:audio_service/audio_service.dart';

class YoutubeDl {
  YoutubeDl({
    required this.videoId,
    this.title,
    this.path,
  });

  final String videoId;
  String? title;
  String? path;

  String get headPhoto => "https://img.youtube.com/vi/$videoId/default.jpg";

  Map<String, dynamic> toMap() {
    return {
      'videoId': videoId,
      'title': title,
      'path': path,
    };
  }

  factory YoutubeDl.fromMap(dynamic _map) {
    Map<String, dynamic> map = Map<String, dynamic>.from(_map);
    return YoutubeDl(
      videoId: map['videoId'] as String,
      title: map['title'],
      path: map['path'],
    );
  }
}

extension Mapper on YoutubeDl {
  MediaItem get toMediaItem {
    return MediaItem(
      id: path!,
      title: title!,
      artUri: Uri.parse(headPhoto),
    );
  }
}
