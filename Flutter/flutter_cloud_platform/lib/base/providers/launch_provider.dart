import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_setting.dart';
import 'package:flutter_cloud_platform/base/dao/account_dao.dart';
import 'package:flutter_cloud_platform/base/network/auth_api.dart';
import 'package:flutter_cloud_platform/base/service/mcs_im_service.dart';
import 'package:flutter_cloud_platform/base/utils/mcs_sp_util.dart';
import 'package:flutter_cloud_platform/guide/guide_page.dart';
import 'package:flutter_cloud_platform/login/models/account.dart';
import 'package:flutter_cloud_platform/main/main_page.dart';
import 'package:flutter_cloud_platform/splash/splash_page.dart';
import 'package:flutter_cloud_platform/login/login.dart';

enum LaunchType {
  splash,
  guidance,
  login,
  main
}

class LaunchProvider extends ChangeNotifier {
  LaunchType _launchType = LaunchType.splash;
  LaunchType get launchType => _launchType;
  set launchType(LaunchType type) {
    _launchType = type;
    notifyListeners();
  }

  Widget launchPage() {
    Future.delayed(splashDuration, () {
      updateLaunchType();
    });

    Widget page;
    switch (_launchType) {
      case LaunchType.splash: {
        page = const SplashPage();
        break;
      }
      case LaunchType.guidance: {
        MCSSpUtil.setBool(keyGuide, false);
        page = const GuidePage();
        break;
      }
      case LaunchType.login: {
        page = const LoginPage();
        break;
      }
      case LaunchType.main: {
        page = const MainPage();
        break;
      }
      default: {
        page = Container();
      }
    }
    return page;
  }

  void updateLaunchType() async {
    bool isShowGuide = MCSSpUtil.getBool(keyGuide, defValue: false);
    // 1. 是否第一次打开应用
    if (_launchType == LaunchType.splash) {
      if (isShowGuide) {
        launchType = LaunchType.guidance;
      } else {
        // 2. 上次是否处于登录成功状态
        AccountDao dao = AccountDao();
        Account? account = await dao.fetchActiveAccount();
        if (account != null) {
          String userId = account.userId ?? '';
          String pwd = account.password ?? '';
          bool success = await MCSIMService.singleton.login(userId, pwd);
          Account? newAccount = await AuthApi.singleton.login(userId, pwd);
          launchType = (success && newAccount != null)? LaunchType.main:LaunchType.login;
        } else {
          launchType = LaunchType.login;
        }
      }
      return;
    }
  }
}