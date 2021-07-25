import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/widgets/fd_app_bar.dart';
import 'package:flutter_deer/widgets/state_layout.dart';

// TODO: 自定义appBar及body
class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FDAppBar(
        centerTitle: "页面不存在",
      ),
      body: StateLayout(
        type: StateType.account,
        hintText: "页面不存在",
      ),
    );
  }
}