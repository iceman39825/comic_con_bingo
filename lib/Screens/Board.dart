import 'package:flutter/material.dart';
import 'dart:math';
import 'package:comic_con_bingo/Models/Cell.dart';
import 'package:comic_con_bingo/Enums/CellStatus.dart';
import 'package:comic_con_bingo/Utilities/GameLogicHelper.dart';
import 'package:comic_con_bingo/Utilities/DatabaseHelper.dart';

class Board extends StatefulWidget {
  Board({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _BoardState createState() => new _BoardState();
}

class _BoardState extends State<Board> {
  DatabaseHelper dbHelper = DatabaseHelper();
  GameLogicHelper gameLogicHelper = GameLogicHelper();
  List<Cell> cells;
  int rowCount = 5;
  int columnCount = 5;
  int count = 0;
  int freeSpaceIndex;
  double itemHeight = 0.0;
  double itemWidth = 0.0;

  @override
  Widget build(BuildContext context) {
    if(cells == null){
      cells = List<Cell>();
      getData();
    }
    gameLogicHelper.SetData(cells, rowCount, columnCount, context);
    var size = MediaQuery.of(context).size;

    itemHeight = (size.height - kToolbarHeight - 24) / 2;
    itemWidth = size.width / 2;
    freeSpaceIndex = ((rowCount~/2) * columnCount) + (columnCount~/2);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        ),
    backgroundColor: Colors.black,
    body: tiles()
    );
  }

  // Function to be called on click
  void _onTileClicked(int index) {
    setState(() {
      if(cells[index].status == CellStatus.SELECTED && index != freeSpaceIndex)
        cells[index].status = CellStatus.NOT_SELECTED;
      else
        gameLogicHelper.Touched(index);
    });
  }

// Get grid tiles
  GridView tiles() {
  return GridView.builder(itemCount: count,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: columnCount, childAspectRatio: (itemWidth / itemHeight), mainAxisSpacing: 4.0, crossAxisSpacing: 4.0),
      padding: const EdgeInsets.all(4.0),
      itemBuilder: (BuildContext context, int position){
    return Container(
      decoration: new BoxDecoration(
              border: new Border.all(color: Colors.blueAccent)),
          child: new GridTile(
            child: new InkResponse(
              enableFeedback: true,
              child: new Center(child: new Text(cells[position].value, textAlign: TextAlign.center, style: new TextStyle(color: cells[position].color, fontSize: 19.0),),),
              onTap: () => _onTileClicked(position),
            ),
    )
    );
  }
  );
  }

  void getData() {
    final dbFuture = dbHelper.initializeDb();
    dbFuture.then((result){
      final valuesFuture = dbHelper.getCellValues();
      valuesFuture.then((result){
        List<Cell> cellsList = List<Cell>();
        int resultCount = result.length;
        debugPrint("resultCount: " + resultCount.toString());
        for(int i = 0; i < resultCount; i++) {
          cellsList.add(Cell.fromObject(result[i]));
        }
        var shuffledCells = shuffle(cellsList);

        shuffledCells[freeSpaceIndex].value = "Free";
        shuffledCells[freeSpaceIndex].status = CellStatus.SELECTED;

        setState(() {
          cells = shuffledCells;
          count = rowCount * columnCount;
          debugPrint("I'm a count: " + count.toString());
        });

        debugPrint("Items " + count.toString());
      });
    });
  }

  List<Cell> shuffle(List list, [int start = 0, int end]) {
    var random = new Random();
    if (end == null) end = list.length;
    int length = end - start;
    while (length > 1) {
      int pos = random.nextInt(length);
      length--;
      var tmp1 = list[start + pos];
      list[start + pos] = list[start + length];
      list[start + length] = tmp1;
    }

    return list;
  }
}