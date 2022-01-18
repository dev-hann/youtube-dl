import 'package:get/get.dart';
import 'package:youtube_dl/models/youtube-dl.dart';
import 'package:youtube_dl/repos/play_repo/src/play_impl.dart';
import 'package:youtube_dl/use_cases/play_use_case/play_use_case.dart';

class PlayController extends GetxService {
  static PlayController find() => Get.find<PlayController>();

  late PlayUseCase _useCase;
  final Rxn<YoutubeDl> _currentItem = Rxn();

  YoutubeDl? get currentItem => _currentItem.value;

  @override
  void onReady() {
    _useCase = PlayUseCase(PlayImpl());
    super.onReady();
  }

  Future setItem(YoutubeDl dl) async {
    _currentItem(dl);
    await _useCase.init(dl.path!);
  }

  Future play() async {
    if (currentItem == null) return;
    await _useCase.play();
  }

  Future pause() async {
    await _useCase.pause();
  }

  Future stop() async {
    await _useCase.stop();
  }
}
