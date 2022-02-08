import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/dao/account_dao.dart';
import 'package:flutter_cloud_platform/login/models/account.dart';

class AccountProvider extends ChangeNotifier {

  Account? _currentAccount;

  AccountProvider() {
    _init();
  }

  Account? get currentAccount => _currentAccount;

  void _init() async {
    AccountDao dao = AccountDao();
    Account? account = await dao.fetchLastTimeAccount();
    update(account);
  }

  void update(Account? account) {
    _currentAccount = account;
    notifyListeners();
  }

  String? headUrl() {
    return _currentAccount?.headUrl;
  }
}