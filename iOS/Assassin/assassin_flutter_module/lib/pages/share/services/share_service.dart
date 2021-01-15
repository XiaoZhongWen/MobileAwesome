import 'dart:convert';
import 'package:assassin_flutter_module/constants.dart';
import 'package:assassin_flutter_module/pages/share/models/share_item.dart';
import 'package:assassin_flutter_plugin/assassin_flutter_plugin.dart';

class ShareService {
  ShareService._privateConstructor();
  static final ShareService shared = ShareService._privateConstructor();
  factory ShareService() {
    return shared;
  }

  Future<List> fetchShares(int offset) async {
    String response = await AssassinFlutterPlugin
        .doRequest(assassin_application_configuration_channel_fetch_shares, {"offset":offset, "pageSize":page_size_of_share});
    List<ShareItem> shareItems = List();
    List list = json.decode(response);
    for(int i = 0; i < list.length; i++) {
      Map map = list[i];
      ShareItem shareItem = ShareItem.fromJson(map);
      shareItems.add(shareItem);
    }
    return shareItems;
  }
}