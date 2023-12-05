import 'dart:convert';

import 'package:challenge_escribo_flutter/app/search/domain/entities/result.dart';

class ResultModel implements Result {
  @override
  final int id;
  @override
  final String title;
  @override
  final String author;
  @override
  final String cover_url;
  @override
  final String download_url;

  const ResultModel({
    required this.id,
    required this.title,
    required this.author,
    required this.cover_url,
    required this.download_url,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'cover_url': cover_url,
      'download_url': download_url,
    };
  }

  static ResultModel fromMap(Map<String, dynamic> map) {
    return ResultModel(
      id: map['id'],
      title: map['title'],
      author: map['author'],
      cover_url: map['cover_url'],
      download_url: map['download_url'],
    );
  }

  String toJson() => json.encode(toMap());

  static ResultModel fromJson(String source) => fromMap(json.decode(source));
}
