import 'package:assassin_flutter_module/channels/application_configuration_channel.dart';
import 'package:assassin_flutter_module/pages/me/models/account.dart';
import 'package:assassin_flutter_module/pages/share/models/share_good.dart';
import 'package:assassin_flutter_module/tools/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ShareGoodsProvider with ChangeNotifier {
  ShareGoodsProvider({this.goods}) {
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

  int numberOfNicknameDisplayed(BuildContext context, double constraintWidth, TextStyle style) {
    if (goods.length == 0) {
      return 0;
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
      return goods.length;
    } else {
      int count = 0;
      str = " 等" + goods.length.toString() + "人觉得很赞";
      for (ShareGood good in goods) {
        str = good.cnname + '、' + str;
        width = StringExtension().widthOf(context, str, style);
        if (width > constraintWidth) {
          break;
        }
        count++;
      }
      return count;
    }
  }
}