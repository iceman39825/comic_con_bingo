import 'package:flutter/material.dart';
import 'package:comic_con_bingo/Screens/Board.dart';

void main() => runApp(new ComicConBingo());

class ComicConBingo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Comic Con Bingo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Board(title: 'Comic Con Bingo'),
    );
  }
}

class ComicConBingoPage extends StatefulWidget {
  ComicConBingoPage({Key key, this.title}) : super(key : key);

  final String title;

  @override
  _ComicConBingoPageState createState() => new _ComicConBingoPageState();
}

class _ComicConBingoPageState extends State<ComicConBingoPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Board(),
    );
  }
}

