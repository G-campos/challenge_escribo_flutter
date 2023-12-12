import 'package:dartz/dartz.dart';
import 'package:challenge_escribo_flutter/app/search/domain/entities/book.dart';
import 'package:challenge_escribo_flutter/app/search/domain/errors/erros.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<Book>>> getBooks(String searchText);
}
