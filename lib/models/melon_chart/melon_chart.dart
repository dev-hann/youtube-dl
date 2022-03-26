import 'sing.dart';

class MelonChart {
  const MelonChart({
    required this.top,
  });

  final List<Sing> top;

  Map<String, dynamic> toMap() {
    return {
      'top': top,
    };
  }

  factory MelonChart.fromMap(Map<String, dynamic> map) {
    return MelonChart(
      top: List<Sing>.from(map['top'] as List),
    );
  }
}
