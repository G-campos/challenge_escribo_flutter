// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter_modular/flutter_modular.dart';
import 'package:challenge_escribo_flutter/app/core/config/config.dart';
import 'package:http/http.dart' as http;

import 'search/domain/repositories/list_repository.dart';
import 'search/domain/usecases/search_by_text.dart';
import 'search/external/escribo/escribo_search_datasource.dart';
import 'search/infra/datasources/search_datasource.dart';
import 'search/infra/repositories/search_repository_impl.dart';
import 'search/presenter/pages/details_page.dart';
import 'search/presenter/pages/guardt.dart';
import 'search/presenter/pages/list_page.dart';
import 'search/presenter/stores/list_store.dart';

class AppModule extends Module {
  AppModule();

  @override
  void binds(i) {
    i.addInstance<http.Client>(http.Client());
    i.add<SearchDatasource>(EscriboSearchDatasource.new);
    i.add<SearchRepository>(SearchRepositoryImpl.new);
    i.add<SearchByText>(SearchByTextImpl.new);
    i.addSingleton<SearchStore>(SearchStore.new, config: storeConfig());
  }

  @override
  void routes(r) {
    r.child('/', child: (_) => const ListPage());
    r.child('/reader',
        child: (_) => DetailsPage(result: r.args.data), guards: [GuardT()]);
  }
}
