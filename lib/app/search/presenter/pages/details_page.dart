import 'package:challenge_escribo_flutter/app/search/domain/entities/result.dart';
import 'package:challenge_escribo_flutter/app/search/presenter/stores/list_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DetailsPage extends StatefulWidget {
  final Result? result;
  const DetailsPage({
    Key? key,
    this.result,
  }) : super(key: key);
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void dispose() {
    Modular.dispose<SearchStore>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(Modular.args.queryParams['id'].toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.result != null ? widget.result!.author : 'Make a search'),
      ),
      body: widget.result != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.result!.cover_url,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(widget.result!.cover_url),
                    ),
                  ),
                  Text(widget.result!.author),
                ],
              ),
            )
          : Center(
              child: ElevatedButton(
                onPressed: () => Modular.to.pushReplacementNamed('/'),
                child: const Text('Make a search'),
              ),
            ),
    );
  }
}
