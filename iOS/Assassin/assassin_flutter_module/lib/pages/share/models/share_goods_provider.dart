import 'package:assassin_flutter_module/channels/application_configuration_channel.dart';
import 'package:assassin_flutter_module/pages/me/models/account.dart';
import 'package:assassin_flutter_module/pages/share/models/share_good.dart';
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
}