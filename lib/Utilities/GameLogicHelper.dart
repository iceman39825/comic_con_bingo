import 'package:comic_con_bingo/Enums/CellStatus.dart';
import 'package:comic_con_bingo/Models/Cell.dart';
import 'package:comic_con_bingo/Utilities/Dialogs.dart';
import 'package:flutter/material.dart';

class GameLogicHelper extends StatelessWidget{
  int _rowCount = 5;
  int _columnCount = 5;
  List<Cell> _cells;
  bool _gameOver = false;
  Dialogs dialogs = new Dialogs();

  BuildContext _context;

  void SetData(List<Cell> cells, int rowCount, int columnCount, BuildContext context)
  {
    _cells = cells;
    _rowCount = rowCount;
    _columnCount = columnCount;
    _context = context;
  }

  bool Touched(int index) {
    if(!_gameOver && _cells[index].status == CellStatus.NOT_SELECTED) {
      _cells[index].status = CellStatus.SELECTED;
      if(!isGameOver()){
        //this.invalidate();
      }
    }
  }

 bool isGameOver(){
  if(markTheLine()){
    _gameOver = true;
    dialogs.confirm(_context, "New Game", "Would you like to start a new game?");
  }

  return _gameOver;
}

  bool markTheLine(){
    int selectedCountInALine;
    for(int i=0;i<_rowCount;i++){
      selectedCountInALine = 0;
      for(int j=0;j<_columnCount;j++){
        if(_cells[(i * _columnCount) + j].status != CellStatus.NOT_SELECTED){
          selectedCountInALine++;
        }
      }
      if(selectedCountInALine == _columnCount){
        for(int j=0;j<_columnCount;j++){
          _cells[(i * _columnCount) + j].status = CellStatus.COMPLETED_A_LINE;
        }
        return true;
      }

      selectedCountInALine = 0;
      for(int j=0;j<_columnCount;j++){
        if(_cells[(j * _columnCount) + i].status != CellStatus.NOT_SELECTED){
          selectedCountInALine++;
        }
      }
      if(selectedCountInALine == _columnCount){
        for(int j=0;j<_columnCount;j++){
          _cells[(j * _columnCount) + i].status = CellStatus.COMPLETED_A_LINE;
        }
        return true;
      }
    }

    selectedCountInALine = 0;
    for(int i=0;i<_rowCount;i++){
      if(_cells[(i * _columnCount) + i].status != CellStatus.NOT_SELECTED){
        selectedCountInALine++;
      }
    }
    if(selectedCountInALine == _rowCount){
      for(int i=0;i<_rowCount;i++){
        _cells[(i * _columnCount) + i].status = CellStatus.COMPLETED_A_LINE;
      }
      return true;
    }

    selectedCountInALine = 0;
    for(int i=0;i<_columnCount;i++){
      if(_cells[((_columnCount * i) + _columnCount - i)-1].status != CellStatus.NOT_SELECTED){
        selectedCountInALine++;
      }
    }
    if(selectedCountInALine == _rowCount){
      for(int i=0;i<_columnCount;i++){
        _cells[((_columnCount * i) + _columnCount - i)-1].status = CellStatus.COMPLETED_A_LINE;
      }
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _context = context;
  }
}