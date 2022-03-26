class Sing {
  const Sing({
    required this.rank,
    required this.title,
    required this.headPhoto,
    required this.artist,
    required this.albumName,
  });

  final String rank;
  final String title;
  final String headPhoto;
  final String artist;
  final String albumName;

  Map<String, dynamic> toMap() {
    return {
      'rank': rank,
      'title': title,
      'headPhoto': headPhoto,
      'artist': artist,
      'albumName': albumName,
    };
  }

  factory Sing.fromMap(dynamic _map) {
    Map<String, dynamic> map = Map<String, dynamic>.from(_map);
    return Sing(
      rank: map['rank'] as String,
      title: map['title'] as String,
      headPhoto: map['headPhoto'] as String,
      artist: map['artist'] as String,
      albumName: map['albumName'] as String,
    );
  }
}
