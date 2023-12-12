import 'package:dartz/dartz.dart' hide Bind;
import 'package:challenge_escribo_flutter/app/search/domain/entities/book.dart';
import 'package:challenge_escribo_flutter/app/search/domain/errors/erros.dart';
import 'package:challenge_escribo_flutter/app/search/domain/repositories/list_repository.dart';
import 'package:challenge_escribo_flutter/app/search/infra/datasources/search_datasource.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchDatasource datasource;

  SearchRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, List<Book>>> getBooks(String searchText) async {
    try {
      final list = await datasource.searchText(searchText);
      if (list == null) {
        return Left<Failure, List<Book>>(DatasourceBookNull());
      }
      if (list.isEmpty) {
        return Left(EmptyList());
      }
      return Right<Failure, List<Book>>(list);
    } catch (e) {
      return Left<Failure, List<Book>>(ErrorSearch());
    }
  }
}
