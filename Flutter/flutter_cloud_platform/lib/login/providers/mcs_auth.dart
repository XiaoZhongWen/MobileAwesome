import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/login/models/mcs_login_data.dart';

typedef LoginCallBack = Future<String?> Function(MCSLoginData);

class MCSAuth extends ChangeNotifier {
  MCSAuth({this.onLogin});

  final LoginCallBack? onLogin;

  String _username = '';
  String get username => _username;
  set username(String username) {
    _username = username;
    notifyListeners();
  }

  String _password = '';
  String get password => _password;
  set password(String password) {
    _password = password;
    notifyListeners();
  }
}