import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Finder Name',
      home: RandomWords(),
    );
  }
}

class _RandomWordsState extends State<RandomWords> {
  final _foundName = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        title: const Text('Name Finder'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _pushSaved,
            tooltip: 'Saved foundName',
          ),
        ],
      ),
      body: Center (
        child:
    ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();

          final index = i ~/ 2;
          if (index >= _foundName.length) {
            _foundName.addAll(generateWordPairs().take(10));
          }

          final alreadySaved = _saved.contains(_foundName[index]);

          return ListTile(
            title: Text(
              _foundName[index].asPascalCase,
              style: _biggerFont,
            ),
            trailing: Icon(
              alreadySaved ? Icons.favorite : Icons.add_box_outlined,
              color: alreadySaved ? Colors.red : Colors.green,
              semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
            ),
            onTap: () {
              setState(() {
                if (alreadySaved) {
                  _saved.remove(_foundName[index]);
                } else {
                  _saved.add(_foundName[index]);
                }
              });
            },
          );
        },
      ),
      ),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _saved.map(
                (pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(context: context, tiles: tiles,).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Favorites'),
              centerTitle: true,
            ),
            body: ListView(
                children: divided,
            ),
          );
        },
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({super.key});

  @override
  State<RandomWords> createState() => _RandomWordsState();
}
