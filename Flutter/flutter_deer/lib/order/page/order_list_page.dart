import 'package:flutter/cupertino.dart';

class OrderListPage extends StatefulWidget {

  OrderListPage({Key? key, required this.index}): super(key: key);

  _OrderListPageState createState() => _OrderListPageState();

  final int index;
}

class _OrderListPageState extends State<OrderListPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        widget.index.toString()
      ),
    );
  }
}