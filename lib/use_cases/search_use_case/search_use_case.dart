import 'package:youtube_dl/models/search_result.dart';
import 'package:youtube_dl/repos/search_repo/search_repo.dart';

class SearchUseCase{
  SearchUseCase(this._repo);

  final SearchRepo _repo;

  Future<List<SearchResult>> search(String value)async{
    return [];
  }
}