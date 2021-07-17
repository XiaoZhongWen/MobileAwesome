import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TipRoute extends StatelessWidget {

  TipRoute({Key key, @required this.title}): super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("提示"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(title),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pop("我是返回值Julien");
              },
              child: Text("返回")
            )
          ],
        ),
      ),
    );
  }
}