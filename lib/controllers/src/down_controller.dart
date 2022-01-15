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

  final RxBool _loading = true.obs;

  bool get isLoading => _loading.value;

  Future _init() async {
    _useCase = DownUseCase(DownImpl());
    await _useCase.initUseCase();
    _loading(false);
  }

  Future downAudio(String videoId) async {
    final _tmpYoutubeDl = YoutubeDl(
      videoId: videoId,
      title: "hello",
    );
    print("down$videoId");
  }
}
