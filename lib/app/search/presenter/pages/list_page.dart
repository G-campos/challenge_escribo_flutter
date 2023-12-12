import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:challenge_escribo_flutter/app/search/domain/entities/book.dart';
import 'package:challenge_escribo_flutter/app/search/domain/errors/erros.dart';

import '../stores/list_store.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Widget _buildList(List<Book> list) {
    if (list.isEmpty) {
      return const Center(
        child: Text('Please, type something...'),
      );
    }
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (_, index) {
        var item = list[index];
        return ListTile(
          leading: Hero(
            tag: item.cover_url,
            child: CircleAvatar(
              backgroundImage: NetworkImage(item.cover_url),
            ),
          ),
          title: Text(item.author),
          onTap: () {
            Modular.to.pushNamed('/details?id=1', arguments: item);
          },
        );
      },
    );
  }

  Widget _buildError(error) {
    if (error is EmptyList) {
      return const Center(
        child: Text('Nothing has been found'),
      );
    } else if (error is ErrorSearch) {
      return const Center(
        child: Text('Escribo error'),
      );
    } else {
      return const Center(
        child: Text('Internal error'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<SearchStore>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Escribo Leitor Ebook'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
            child: TextField(
              onChanged: store.setSearchText,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search...',
              ),
            ),
          ),
          Expanded(
            child: store.when(
              onState: _buildList,
              onLoading: (loading) =>
                  const Center(child: CircularProgressIndicator()),
              onError: _buildError,
            ),
          ),
        ],
      ),
    );
  }
}
