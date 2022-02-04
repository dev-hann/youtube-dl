import 'package:audio_service/audio_service.dart';
import 'package:youtube_dl/models/youtube.dart';

class YoutubeDl extends Youtube {
  YoutubeDl({
    required String videoId,
    required DateTime publishedAt,
    required String title,
    required String description,
    required Duration? duration,
    this.path,
    this.headPhotoPath,
  }) : super(
          videoId: videoId,
          publishedAt: publishedAt,
          title: title,
          description: description,
          duration: duration,
        );

  String? path;
  String? headPhotoPath;

  @override
  Map<String, dynamic> toMap() {
    return {
      'videoId': videoId,
      'publishedAt': publishedAt,
      'title': title,
      'description': description,
      'path': path,
      'headPhotoPath': headPhotoPath,
      'duration': duration.inSeconds,
    };
  }

  factory YoutubeDl.fromMap(dynamic _map) {
    Map<String, dynamic> map = Map<String, dynamic>.from(_map);
    return YoutubeDl(
      videoId: map['videoId'] as String,
      publishedAt: map['publishedAt'] as DateTime,
      title: map['title'] as String,
      description: map['description'] as String,
      path: map['path'] as String,
      headPhotoPath: map['headPhotoPath'] as String,
      duration: map['duration'] == null
          ? Duration.zero
          : Duration(seconds: map['duration']),
    );
  }
}

extension Mapper on YoutubeDl {
  MediaItem get mediaItem {
    return MediaItem(
      id: path!,
      title: title,
      artUri: headPhotoPath == null ? null : Uri.file(headPhotoPath!),
    );
  }
}
