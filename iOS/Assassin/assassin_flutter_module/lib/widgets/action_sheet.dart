import 'package:assassin_flutter_module/constants.dart';
import 'package:flutter/material.dart';

typedef ActionCallBack = void Function(int index);

class ActionSheet extends StatelessWidget {
  double _height;
  final List<String> _titles;
  final ActionCallBack _actionCallBack;

  ActionSheet(Key key, this._titles, this._actionCallBack) : super(key: key) {
    _height = _titles.length * action_sheet_item_height + 100;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> list = List();
    int count = _titles.length;
    for (int i = 0; i < count; i++) {
      list.add(_sheetItem(i, _titles[i], (i + 1 < count)? true: false));
    }

    return Container(
      height: _height,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(default_margin),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(action_sheet_radius),
              child: Column(
                children: list,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: default_margin, right: default_margin),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(action_sheet_radius),
              child: _sheetItem(-1, "取消", false)
            ),
          )
        ],
      )
    );
  }

  Widget _sheetItem(int index, String title, bool divider) {
    return Container(
      decoration: BoxDecoration(
        color: index == -1? Colors.white : Colors.white.withOpacity(0.8),
        border: Border(
          bottom: BorderSide(
            width: divider?divide_height:0.0
          )
        )
      ),
      height: action_sheet_item_height,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            flex: 1,
            child: FlatButton(
              onPressed: () => _actionCallBack(index),
              child: Text(title, style: TextStyle(
                color: Colors.blue,
                fontSize: action_sheet_font_size,
                fontWeight: index == -1? action_sheet_cancel_font_weight: action_sheet_font_weight
              ),),
            ),
          ),
        ],
      ),
    );
  }
}
