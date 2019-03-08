import 'package:flutter/material.dart';
import 'package:comic_con_bingo/Enums/CellStatus.dart';

class Cell {
  int _id;
  String _value;
  CellStatus _status = CellStatus.NOT_SELECTED;
  Color _color = Colors.white;

  Cell(this._value, this._status);
  Cell.withId(this._id, this._value, this._status);

  int get id => _id;
  String get value => _value;
  CellStatus get status => _status;
  Color get color => _color;

  set value(String newValue)
  {
    _value = newValue;
  }

  set status(CellStatus newStatus)
  {
    _status = newStatus;
    if(_status == CellStatus.SELECTED) {
      _color = Colors.blue;
    }
    if(_status == CellStatus.NOT_SELECTED)
      _color = Colors.white;
    if(_status == CellStatus.COMPLETED_A_LINE)
      _color = Colors.red;
  }

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map["value"] = _value;
    map["status"] = _status;

    if(_id != null){
      map["id"] = _id;
    }

    return map;
  }

  Cell.fromObject(dynamic o){
    this._id = o["id"];
    this._value = o["value"];
    this._status = CellStatus.NOT_SELECTED;
    debugPrint("My status is " + this._status.toString());
  }
}