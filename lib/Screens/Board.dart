import 'package:flutter/material.dart';
import 'package:comic_con_bingo/Models/CellValue.dart';
import 'package:comic_con_bingo/Utilities/DatabaseHelper.dart';

class Board extends StatefulWidget {
  Board({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _BoardState createState() => new _BoardState();
}

class _BoardState extends State<Board> {
  DatabaseHelper helper = DatabaseHelper();
  List<CellValue> values;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if(values == null){
      values = List<CellValue>();
      getData();
    }
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        ),
    body: new GridView.count(
        crossAxisCount: 5,
        childAspectRatio: (itemWidth / itemHeight),
        padding: const EdgeInsets.all(4.0),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: _getTiles(),
      ),
    );
  }

  // Function to be called on click
  void _onTileClicked(int index) {
    debugPrint("You tapped on item $index");
  }

// Get grid tiles
  List<Widget> _getTiles() {
    final List<Widget> tiles = <Widget>[];
    for (int i = 0; i <= 24; i++) {
      tiles.add(new Container(
          decoration: new BoxDecoration(
              border: new Border.all(color: Colors.blueAccent)),
          child: new GridTile(
            child: new InkResponse(
              enableFeedback: true,
              child: new Center(child: Text(values[i].value)),
              onTap: () => _onTileClicked(i),
            ),
          )));
    }
    return tiles;
  }

  void getData(){
    final dbFuture = helper.initializeDb();
    dbFuture.then((result){
      final valuesFuture = helper.getCellValues();
      valuesFuture.then((result){
        List<CellValue> valuesList = List<CellValue>();
        count = result.length;
        for(int i = 0; i < count; i++){
          valuesList.add(CellValue.fromObject(result[i]));
          debugPrint(valuesList[i].value);

        }
        setState(() {
          values = valuesList;
          count = count;
        });
        debugPrint("Items " + count.toString());
      });
    });
  }
}