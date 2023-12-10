import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:challenge_escribo_flutter/app/search/domain/entities/result.dart';
import 'package:challenge_escribo_flutter/app/search/domain/errors/erros.dart';

import '../stores/list_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _buildList(List<Result> list) {
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
            Modular.to.pushNamed('/reader?id=1', arguments: item);
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

class CardExampleApp extends StatelessWidget {
  const CardExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Card Sample')),
        body: const CardExample(),
      ),
    );
  }
}

class CardExample extends StatelessWidget {
  const CardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.album),
              title: Text('The Enchanted Nightingale'),
              subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('BUY TICKETS'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('LISTEN'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

