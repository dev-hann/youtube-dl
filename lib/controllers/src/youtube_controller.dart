import 'package:get/get.dart';
import 'package:youtube_dl/models/dl_snapshot.dart';
import 'package:youtube_dl/models/youtube_dl.dart';
import 'package:youtube_dl/repos/down_repo/src/down_impl.dart';
import 'package:youtube_dl/use_cases/down_use_case/down_use_case.dart';

class YoutubeController extends GetxService {
  static YoutubeController find() => Get.find<YoutubeController>();

  late DownUseCase _useCase;

  @override
  void onReady() {
    _init();
    super.onReady();
  }

  final RxList<YoutubeDl> dlList = <YoutubeDl>[].obs;

  bool isContains(String videoId) {
    return dlList.map((element) => element.videoId).contains(videoId);
  }

  int _indexWhereDlList(String videoId) {
    return dlList.indexWhere((element) => element.videoId == videoId);
  }

  List<YoutubeDl> findItemList(List<String> idList) {
    final List<YoutubeDl> res = <YoutubeDl>[];
    for (final item in idList) {
      int index = _indexWhereDlList(item);
      if (index == -1) continue;
      res.add(dlList[index]);
    }
    return res;
  }

  final RxBool _loading = true.obs;

  bool get isLoading => _loading.value;

  Future _init() async {
    _useCase = DownUseCase(DownImpl());
    await _useCase.initUseCase();
    dlList(_useCase.loadDownList());
    _loading(false);
  }

  final RxMap<String, DlSnapshot> _snapshotMap =
      <String, DlSnapshot>{}.obs;

  DlSnapshot snapshot(String videoId) {
    return _snapshotMap[videoId] ?? DlSnapshot();
  }

  Future downAudio(YoutubeDl dl) async {
    _snapshotMap[dl.videoId] = DlSnapshot();
    final _res = await _useCase.downloadAudio(
      dl: dl,
      progressState: (state, progress) {
        _snapshotMap[dl.videoId] = DlSnapshot(
          state: state,
          progress: progress,
        );
      },
    );
    if (_res) {
      dlList.add(dl);
    }
  }

  Future<void> stopDownloadAudio(String videoId) async {
    _useCase.stopDownloadAudio(videoId);
    await Future.delayed(1.seconds);
    _snapshotMap.remove(videoId);
  }

  Future removeItem(YoutubeDl dl) async {
    await _useCase.removeDl(dl);
    dlList.remove(dl);
  }
}
