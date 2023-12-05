import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:challenge_escribo_flutter/app/search/infra/datasources/search_datasource.dart';
import 'package:challenge_escribo_flutter/app/search/infra/models/result_model.dart';
import 'package:http/http.dart';

class EscriboSearchDatasource implements SearchDatasource {
  final Client client;

  EscriboSearchDatasource(this.client);

  @override
  Future<List<ResultModel>?> searchText(String textSearch) async {
    // var url = Uri.parse('https://api.github.com/search/users?q=$textSearch');
    var url = Uri.parse('https://escribo.com/books.json');
    var result = await client.get(url);
    if (result.statusCode == 200) {
      final json = jsonDecode(result.body);
      debugPrint('execute datasource');
      var jsonList = json['items'] as List;
      var list = jsonList
          .map((item) => ResultModel(
              id: item['id'],
              title: item['title'],
              author: item['author'],
              cover_url: item['cover_url'],
              download_url: item['download_url']))
          .toList();
      return list;
    } else {
      throw Exception();
    }
  }
}
