import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:youtube_dl/models/search_result.dart';
import 'package:youtube_dl/repos/search_repo/src/search_impl.dart';
import 'package:youtube_dl/use_cases/search_use_case/search_use_case.dart';

class SearchViewModel {

  late SearchUseCase _useCase;
  final Rx<ConnectionState> _state = ConnectionState.none.obs;

  ConnectionState get state => _state.value;

  void init() async {
    _useCase = SearchUseCase(SearchImpl());
  }

  final TextEditingController searchController = TextEditingController();

  String get searchText => searchController.text;

  final RxList<SearchResult> resultList = <SearchResult>[].obs;

  void onTapSearch() async {
    if (state == ConnectionState.waiting) return;
    resultList.clear();
    final _res = await _useCase.search(searchText);
    if (_res.isNotEmpty) {}
    _state(ConnectionState.done);
  }
}
