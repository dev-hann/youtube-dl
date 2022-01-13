import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:youtube_dl/controllers/down_controller.dart';
import 'package:youtube_dl/models/search_result.dart';
import 'package:youtube_dl/repos/search_repo/src/search_impl.dart';
import 'package:youtube_dl/use_cases/search_use_case/search_use_case.dart';

class SearchViewModel {
  late SearchUseCase _useCase;
  final Rx<ConnectionState> _state = ConnectionState.none.obs;
  final DownController _downController = DownController.find();

  ConnectionState get state => _state.value;

  void init() async {
    _useCase = SearchUseCase(SearchImpl());
  }

  final TextEditingController searchController = TextEditingController();

  String get searchText => searchController.text;

  final Rxn<SearchResult> _result = Rxn();

  SearchResult? get result => _result.value;

  List<ResultItem> get items {
    if (result == null) return [];
    return result!.items;
  }

  void onTapSearch() async {
    if (state == ConnectionState.waiting) return;
    final _res = await _useCase.search(searchText);
    _result(_res);
    _state(ConnectionState.done);
  }

  void onTapDown(String videoId) {
    _downController.downAudio(videoId);
  }
}
