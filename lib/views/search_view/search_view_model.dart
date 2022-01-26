import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:youtube_dl/controllers/src/down_controller.dart';
import 'package:youtube_dl/controllers/src/play_controller.dart';
import 'package:youtube_dl/models/search_result.dart';
import 'package:youtube_dl/repos/search_repo/src/search_impl.dart';
import 'package:youtube_dl/use_cases/search_use_case/search_use_case.dart';

class SearchViewModel {
  late SearchUseCase _useCase;
  final Rx<ConnectionState> _state = ConnectionState.none.obs;
  final DownController _downController = DownController.find();

  ConnectionState get state => _state.value;

  final RxBool _loading = true.obs;

  bool get isLoading => _loading.value && _downController.isLoading;

  void init() async {
    _useCase = SearchUseCase(SearchImpl());
    _loading(false);
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

  double? progress(String videoId) {
    if (_downController.dlList
        .map((element) => element.videoId)
        .contains(videoId)) {
      return 1;
    }
    return _downController.progressMap[videoId];
  }

  final PlayController _playController = PlayController.find();

  Future<void> onTapDown(ResultItem item) async {
    final _tmpDl = item.toYoutubeDl;
    await _downController.downAudio(_tmpDl);
    await _playController.addPlayList(0, _tmpDl.videoId);
  }

  void onTapPlay(ResultItem item) {}

  void onTapStop(ResultItem item) {
    _downController.stopDownloadAudio(item.videoId);
  }
}
