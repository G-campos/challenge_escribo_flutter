import 'package:challenge_escribo_flutter/app/search/infra/models/result_model.dart';

abstract class SearchDatasource {
  Future<List<BookModel>?> searchText(String textSearch);
}
