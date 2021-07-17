import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SharedDataWidget extends InheritedWidget {
  final int data;

  SharedDataWidget({
    @required this.data,
    Widget child
  }) :super(child: child);

  static SharedDataWidget of(BuildContext context) {
    return context.getElementForInheritedWidgetOfExactType<SharedDataWidget>().widget;
  }

  @override
  bool updateShouldNotify(covariant SharedDataWidget oldWidget) {
    return oldWidget.data != data;
  }
}

class _TestWidget extends StatefulWidget {
  @override
  __TestWidgetState createState() => __TestWidgetState();
}

class __TestWidgetState extends State<_TestWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      SharedDataWidget.of(context).data.toString()
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("Dependencies change");
  }
}

class InheritedWidgetTestRoute extends StatefulWidget {
  _InheritedWidgetTestRouteState createState() => _InheritedWidgetTestRouteState();
}

class _InheritedWidgetTestRouteState extends State<InheritedWidgetTestRoute> {

  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SharedDataWidget(
        data: count,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: _TestWidget(),
            ),
            RaisedButton(
                onPressed: () {
                  setState(() {
                    count++;
                  });
                },
              child: Text("Increment"),
            )
          ],
        ),
      ),
    );
  }
}