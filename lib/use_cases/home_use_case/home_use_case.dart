import 'package:youtube_dl/models/melon_chart/melon_chart.dart';
import 'package:youtube_dl/repos/home_repo/home_repo.dart';

class HomeUseCase {
  HomeUseCase(this.repo);

  final HomeRepo repo;

  Future initUseCase() async {
    await repo.initRepo();
  }

  Future<MelonChart?> loadMelonChart() async {
    final _res = await repo.loadMelonChart();
    if (_res == null) return null;
    return MelonChart.fromMap(_res);
  }
}
