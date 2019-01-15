class CellValue {
  int _id;
  String _value;

  CellValue(this._value);
  CellValue.withId(this._id, this._value);

  int get id => _id;
  String get value => _value;

  set value(String newValue)
  {
    _value = newValue;
  }

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map["value"] = _value;

    if(_id != null){
      map["id"] = _id;
    }

    return map;
  }

  CellValue.fromObject(dynamic o){
    this._id = o["id"];
    this._value = o["value"];
  }
}