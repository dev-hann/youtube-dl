import 'package:get/get.dart';
import 'package:youtube_dl/models/youtube-dl.dart';
import 'package:youtube_dl/repos/down_repo/src/down_impl.dart';
import 'package:youtube_dl/use_cases/down_use_case/down_use_case.dart';

class DownController extends GetxService {
  static DownController find() => Get.find<DownController>();

  late DownUseCase _useCase;

  @override
  void onReady() {
    _init();
    super.onReady();
  }

  final RxList<YoutubeDl> dlList = <YoutubeDl>[].obs;

  final RxBool _loading = true.obs;

  bool get isLoading => _loading.value;

  Future _init() async {
    _useCase = DownUseCase(DownImpl());
    await _useCase.initUseCase();
    _loading(false);
  }

  final RxMap<String, double> progressMap = <String, double>{}.obs;

  Future downAudio(YoutubeDl dl) async {
    await _useCase.downloadAudio(dl, (count, total) {
      final _progress = count / total;
      _updateProgress(dl.videoId, _progress);
      if (_progress == 1) {
        _addDl(dl);
      }
    });
  }

  Future<void> stopDownloadAudio(String videoId) async {
    _useCase.stopDownloadAudio(videoId);
    await Future.delayed(1.seconds);
    progressMap.remove(videoId);
  }

  void _updateProgress(String key, double progress) {
    progressMap[key] = progress;
  }

  void _addDl(YoutubeDl dl) {
    if (!dlList.contains(dl)) {
      dlList.add(dl);
    }
  }
}
