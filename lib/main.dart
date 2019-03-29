import 'package:flutter/material.dart';
import 'package:comic_con_bingo/Screens/Board.dart';

void main() => runApp(new RestartWidget(
  child: new MaterialApp(
    title: 'Comic Con Bingo',
    theme: new ThemeData(
      primarySwatch: Colors.blue,),
    home: Board(title: 'Comic Con Bingo'),
  ),
  )
);

class RestartWidget extends StatefulWidget {
  final Widget child;
  RestartWidget({this.child});

  static restartApp(BuildContext context) {
//    final RestartWidgetState state =
//    context.ancestorStateOfType(const TypeMatcher<RestartWidgetState>());
//    debugPrint("I'm a state: " + state.toString());
//    state.restartApp();
      runApp(new RestartWidget(
        child: new MaterialApp(
          title: 'Comic Con Bingo',
          theme: new ThemeData(
            primarySwatch: Colors.blue,),
          home: Board(title: 'Comic Con Bingo'),
        ),
      ));
  }

  @override
  RestartWidgetState createState() => new RestartWidgetState();
}

class RestartWidgetState extends State<RestartWidget> {
  Key key = new GlobalKey();
//
//  void restartApp() {
//    this.setState(() {
//      key = new UniqueKey();
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      key: key,
      child: widget.child,
    );
  }
}
