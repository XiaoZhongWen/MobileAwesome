import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CounterWidget extends StatefulWidget {

  final int initValue;
  CounterWidget({Key key, @required this.initValue}): super(key: key);

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {

  int _counter;
  @override
  void initState() {
    super.initState();
    _counter = widget.initValue;
    print("initState...");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies...");
  }

  @override
  Widget build(BuildContext context) {
    print("build...");
    return Scaffold(
      body: Center(
        child: FlatButton(
            onPressed: (){
              setState(() {
                _counter++;
              });
            }
            ,   child: Text("$_counter")),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant CounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget...");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("reassemble...");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactivate...");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose...");
  }

}