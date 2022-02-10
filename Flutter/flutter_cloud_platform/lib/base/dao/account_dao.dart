import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/db/mcs_db_service.dart';
import 'package:flutter_cloud_platform/login/models/account.dart';

class AccountDao {
  /*
  * 保存账号
  * */
  Future<bool> saveAccount(Account account) async {
    String userId = account.userId ?? '';
    String pwd = account.password ?? '';
    bool result = true;
    if (userId.isNotEmpty && pwd.isNotEmpty) {
      Map<String, dynamic> json = account.toJson();
      json['active'] = 1;
      json['timestamp'] = DateTime.now().millisecondsSinceEpoch;
      await inactivateOtherAccount();
      Account? acc = await fetchAccountWithUserId(userId);
      if (acc == null) {
        result = await MCSDBService.singleton.insert(accountTableName, json);
      } else {
        int rows = await MCSDBService.singleton.update(accountTableName, json, where: 'userId = ?', whereArgs: [userId]);
        result = rows > 0;
      }
    }
    return result;
  }

  /*
  * 获取userId对应的账号
  * */
  Future<Account?> fetchAccountWithUserId(String userId) async {
    List<Map<String, Object?>> list = await MCSDBService.singleton.query(accountTableName, where: 'userId = ?', whereArgs: [userId]);
    if(list.isEmpty) {
      return null;
    } else {
      Map<String, Object?> json = list.first;
      Account account = Account.fromJson(json);
      return account;
    }
  }

  /*
  * 获取active=1的账号
  * */
  Future<Account?> fetchActiveAccount() async {
    List<Map<String, Object?>> list = await MCSDBService.singleton.query(accountTableName, where: 'active = ?', whereArgs: [1]);
    if (list.isNotEmpty) {
      Map<String, Object?> json = list.first;
      Account account = Account.fromJson(json);
      return account;
    } else {
      return null;
    }
  }

  Future<Account?> fetchLastTimeAccount() async {
    List<Map<String, Object?>> list = await MCSDBService.singleton.query(accountTableName, orderBy: "timestamp DESC");
    if (list.isNotEmpty) {
      Map<String, Object?> json = list.first;
      Account account = Account.fromJson(json);
      return account;
    } else {
      return null;
    }
  }

  /*
  * 重置所有active=1的账号为0
  * */
  Future<void>? inactivateOtherAccount() async {
    await MCSDBService.singleton.update(accountTableName, {'active':0}, where: 'active = ?', whereArgs: [1]);
  }

  Future<void>? deleteAccountWithUserId(String userId) async {
    await MCSDBService.singleton.delete(accountTableName, where: 'userId = ?', whereArgs: [userId]);
  }


}