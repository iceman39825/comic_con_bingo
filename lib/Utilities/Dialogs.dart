import 'package:flutter/material.dart';

class Dialogs{
  information(BuildContext context, String title, String content){
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK")
            )
          ]
        );
      }
    );
  }

  confirm(BuildContext context, String title, String content){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
              title: Text(title),
              content: Text(content),
              actions: <Widget>[
                FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("No")
                ),
                FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Yes")
                ),
              ]
          );
        }
    );
  }
}