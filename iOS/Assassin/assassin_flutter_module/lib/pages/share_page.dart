import 'package:flutter/material.dart';
import 'package:assassin_flutter_plugin/assassin_flutter_plugin.dart';

class SharePage extends StatefulWidget {
  @override
  _SharePageState createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: RaisedButton(
            onPressed: () => {
              AssassinFlutterPlugin.doRequest("https://www.baidu.com", {
                "key1": "value1",
                "key2": "value2"
              })
            },
            color: Colors.blue,
            child: Text("doRequest", style: TextStyle(
              fontSize: 16,
              color: Colors.white
            ),),
          ),
        ),
      ),
    );
  }
}
