import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';

class MCSMemoryCache {
  static final MCSMemoryCache singleton = MCSMemoryCache._();
  MCSMemoryCache._() {}

  Map<String, dynamic> cache = {};

  void store(String key, dynamic value) {
    cache[key] = value;
  }

  /*
  * 获取access token
  * */
  String fetchAccessToken() {
    String? accessToken = cache[accessTokenKey] as String?;
    return accessToken ?? '';
  }

  /*
  * 获取access token的过期时间
  * */
  int fetchExpire() {
    int? expire = cache[expireKey] as int?;
    return expire ?? 0;
  }

  /*
  * 获取用户id
  * */
  String? fetchAccountId() {
    String? accountId = cache[userIdKey] as String?;
    return accountId;
  }

  /*
  * 获取用户昵称
  * */
  String? fetchAccountDisplayName() {
    String? nickname = cache[nicknameKey] as String?;
    return nickname;
  }
}