import 'dart:convert';
import 'package:assassin_flutter_module/pages/me/models/account.dart';
import 'package:assassin_flutter_module/pages/me/models/me_params.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:color/color.dart' as Ex;
import '../constants.dart';

class ApplicationConfigurationChannel {
  ApplicationConfigurationChannel._privateConstructor();
  static final shared = ApplicationConfigurationChannel._privateConstructor();
  static final MethodChannel _channel = MethodChannel(assassin_application_configuration_channel);
  factory ApplicationConfigurationChannel() {
    return shared;
  }

  Color _themeColor;
  Account _account;

  Future<Color> fetchThemeColor() async {
    String theme;
    try {
      theme = await _channel.invokeMethod(assassin_application_configuration_channel_fetch_theme_color);
    } catch (e) {
      theme = default_theme_color;
    }
    Ex.HexColor hexColor = Ex.HexColor(theme);
    _themeColor = Color.fromARGB(255, hexColor.r, hexColor.g, hexColor.b);
    return _themeColor;
  }

  Color fetchThemeColorSync() {
    return _themeColor;
  }

  Future<Account> fetchAccount() async {
    Account account;
    try {
      String jsonStr = await _channel.invokeMethod(assassin_application_configuration_channel_fetch_account);
      account = Account.fromJson(json.decode(jsonStr));
      _account = account;
    } catch (e) {
      print(e);
    }
    return account;
  }

  Account fetchAccountSync() {
    return _account;
  }

  Future<MeParams> fetchTabs() async {
    MeParams params;
    try {
      String tabsJson = await _channel.invokeMethod(assassin_application_configuration_channel_fetch_tabs);
      params = MeParams.fromJson(json.decode(tabsJson));
    } catch (e) {
      print(e);
    }
    return params;
  }
}