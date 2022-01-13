import 'package:youtube_dl/models/search_result.dart';
import 'package:youtube_dl/repos/search_repo/search_repo.dart';

class SearchUseCase {
  SearchUseCase(this._repo);

  final SearchRepo _repo;

  Future<SearchResult> search(String query) async {
    final _res = await _repo.searchAudio(query);
    return SearchResult.fromMap(_res.data);
  }
}
