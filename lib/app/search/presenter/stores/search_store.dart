import 'dart:async';

import 'package:challenge_escribo_flutter/app/search/domain/entities/result.dart';
import 'package:challenge_escribo_flutter/app/search/domain/usecases/search_by_text.dart';
import 'package:flutter_triple/flutter_triple.dart';

class SearchStore extends Store<List<Result>> {
  final SearchByText searchByText;

  SearchStore(this.searchByText) : super([]);

  Timer? timer;

  void setSearchText(String value) {
    setLoading(true);
    timer?.cancel();

    timer = Timer(const Duration(milliseconds: 500), () {
      searchByText(value).then((value) => value.fold(setError, update));
    });
  }
}
