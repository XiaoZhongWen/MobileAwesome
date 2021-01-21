import 'package:assassin_flutter_module/channels/application_configuration_channel.dart';
import 'package:assassin_flutter_module/pages/me/models/account.dart';
import 'package:assassin_flutter_module/pages/share/models/share_good.dart';
import 'package:assassin_flutter_module/tools/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ShareGoodsProvider with ChangeNotifier {
  int _index;
  ShareGoodsProvider(int index, {this.goods}) {
    _index = index;
    Account account = ApplicationConfigurationChannel.shared.fetchAccountSync();
    if (account != null) {
      for (ShareGood good in goods) {
        if (good.replier == account.username) {
          _good = good;
          break;
        }
      }
    }
  }

  final List<ShareGood> goods;
  ShareGood _good;
  String _nicknames = "";
  String _desc = "";

  String get nicknames => _nicknames;
  String get desc => _desc;
  int get index => _index;

  void like(ShareGood good) {
    _good = good;
    goods.add(good);
    notifyListeners();
  }

  void revoke() {
    if (_good != null) {
      goods.remove(_good);
      notifyListeners();
    }
  }

  bool isOverflow(BuildContext context, double constraintWidth, TextStyle style) {
    if (goods.length == 0) {
      return false;
    }
    String str = "";
    for (ShareGood good in goods) {
      str += good.cnname;
      if (goods.last != good) {
        str += "、";
      }
    }
    double width = StringExtension().widthOf(context, str, style);
    if (width <= constraintWidth) {
      _nicknames = str;
      return false;
    } else {
      _desc = " 等" + goods.length.toString() + "人觉得很赞";
      _nicknames = "";
      for (ShareGood good in goods) {
        _nicknames += good.cnname + '、';
        str = _nicknames + _desc;
        width = StringExtension().widthOf(context, str, style);
        if (width > constraintWidth) {
          _nicknames = _nicknames.substring(0, _nicknames.length - good.cnname.length - 2);
          break;
        }
      }
      return true;
    }
  }
}