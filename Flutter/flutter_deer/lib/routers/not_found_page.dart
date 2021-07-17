import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// TODO: 自定义appBar及body
class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("页面不存在"),
      ),
      body: Center(
        child: Text("页面不存在"),
      ),
    );
  }
}