import 'package:get/get.dart';
import 'package:youtube_dl/models/melon_chart/melon_chart.dart';
import 'package:youtube_dl/repos/home_repo/src/home_impl.dart';
import 'package:youtube_dl/use_cases/home_use_case/home_use_case.dart';

class HomeController extends GetxController {
  late HomeUseCase _useCase;

  @override
  void onReady() {
    _init();
    super.onReady();
  }

  final RxBool _loading = true.obs;

  bool get isLoading => _loading.value;

  void _init() async {
    _useCase = HomeUseCase(HomeImpl());
    await _useCase.initUseCase();
    await _loadMelonChart();
    _loading(false);
  }

  final Rx<MelonChart?> _melonChart = Rxn();

  Future _loadMelonChart() async {
    final _res = await _useCase.loadMelonChart();
    if (_res == null) return;
    _melonChart(_res);
  }
}
