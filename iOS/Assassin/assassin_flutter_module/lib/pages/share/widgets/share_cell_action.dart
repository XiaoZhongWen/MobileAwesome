import 'package:flutter/widgets.dart';

class ShareCellAction extends StatelessWidget {

  ShareCellAction({Key key, this.isLike, @required this.onChanged}): super(key: key);

  final bool isLike;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

