class FireResult {
  FireResult({
    required this.uri,
    required this.tunnels,
  });

  final String uri;
  final List<Tunnel> tunnels;

  Map<String, dynamic> toMap() {
    return {
      'uri': uri,
      'tunnels': tunnels,
    };
  }

  factory FireResult.fromMap(dynamic _map) {
    Map<String, dynamic> map = Map<String, dynamic>.from(_map);
    return FireResult(
      uri: map['Uri'] as String,
      tunnels: (map['Tunnels'] as List).map((e) => Tunnel.fromMap(e)).toList(),
    );
  }
}

class Tunnel {
  const Tunnel({
    required this.name,
    required this.proto,
    required this.publicUrl,
    required this.uri,
  });

  final String name;
  final String proto;
  final String publicUrl;
  final String uri;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'proto': proto,
      'publicUrl': publicUrl,
      'uri': uri,
    };
  }

  factory Tunnel.fromMap(dynamic _map) {
    Map<String, dynamic> map = Map<String, dynamic>.from(_map);
    return Tunnel(
      name: map['Name'] as String,
      proto: map['Proto'] as String,
      publicUrl: map['PublicUrl'] as String,
      uri: map['Uri'] as String,
    );
  }
}
