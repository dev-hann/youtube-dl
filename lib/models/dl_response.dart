class DlResponse {
  const DlResponse({
    required this.dateTime,
    required this.result,
    required this.data,
  });

  final int dateTime;
  final bool result;
  final String data;

  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime,
      'result': result,
      'data': data,
    };
  }

  factory DlResponse.fromMap(dynamic _map) {
    Map<String, dynamic> map = Map<String, dynamic>.from(_map);
    return DlResponse(
      dateTime: map['dateTime'] as int,
      result: map['result'] as bool,
      data: map['data'] as String,
    );
  }
}
