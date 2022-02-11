import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_title.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MCSTitle('搜索'),
      ),
    );
  }
}