import 'package:flutter/material.dart';

class MCSPhotoBrowser extends StatefulWidget {
  MCSPhotoBrowser({Key? key, required this.index, required this.datasource}) : super(key: key);

  int index;
  List<Map<String, String?>> datasource;

  @override
  _MCSPhotoBrowserState createState() => _MCSPhotoBrowserState();
}

class _MCSPhotoBrowserState extends State<MCSPhotoBrowser> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
