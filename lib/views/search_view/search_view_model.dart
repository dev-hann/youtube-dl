import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:youtube_dl/controllers/src/audio_controller.dart';
import 'package:youtube_dl/controllers/src/youtube_controller.dart';
import 'package:youtube_dl/models/download_snapshot.dart';
import 'package:youtube_dl/models/search_result.dart';
import 'package:youtube_dl/repos/search_repo/src/search_impl.dart';
import 'package:youtube_dl/use_cases/search_use_case/search_use_case.dart';

class SearchViewModel {
  SearchViewModel(this.searchTag) {
    init();
  }

  final String searchTag;
  late SearchUseCase _useCase;
  final Rx<ConnectionState> _state = ConnectionState.none.obs;
  final YoutubeController _downController = YoutubeController.find();

  ConnectionState get state => _state.value;

  final RxBool _loading = true.obs;

  bool get isLoading => _loading.value && _downController.isLoading;

  void init() async {
    _useCase = SearchUseCase(SearchImpl());
    _loading(false);
    await Future.delayed(const Duration(milliseconds: 300));
    showAppBar();
  }

  final RxDouble _appBarOpacity = 0.0.obs;

  double get appBarOpacity => _appBarOpacity.value;

  void showAppBar() {
    _appBarOpacity(1);
  }

  void hideAppBar() {
    _appBarOpacity(0);
  }

  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocus = FocusNode();

  String get searchText => searchController.text;

  final Rxn<SearchResult> _result = Rxn();

  SearchResult? get result => _result.value;

  List<ResultItem> get items {
    if (result == null) return [];
    return result!.items;
  }

  void onTapSearch() async {
    if (state == ConnectionState.waiting) return;
    _state(ConnectionState.waiting);
    searchFocus.unfocus();

    final _res = await _useCase.search(searchText);
    _result(_res);
    _state(ConnectionState.done);
  }

  DownloadSnapshot snapshot(String videoId) {
    if (_downController.isContains(videoId)) {
      return DownloadSnapshot.done();
    }
    return _downController.snapshot(videoId);
  }

  void onTapClose() {
    hideAppBar();
    Get.back();
  }

  final AudioController audioController = AudioController.find();

  Future<void> onTapDown(ResultItem item) async {
    final _tmpDl = item.toYoutubeDl;
    await _downController.downAudio(_tmpDl);
    await audioController.addItem(_tmpDl.videoId);
  }

  Future<void> onTapPlay(ResultItem item) async {
    await audioController.setYoutubeDl(item.toYoutubeDl);
    await audioController.play();
  }

  void onTapStop(ResultItem item) {
    _downController.stopDownloadAudio(item.videoId);
  }
}
