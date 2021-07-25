
import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/login/login_router.dart';
import 'package:flutter_deer/res/constants.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/image_utils.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences_extension/shared_preferences_extension.dart';

class SplashPage extends StatefulWidget {

  const SplashPage({Key? key}): super(key: key);

  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  int _status = 0;
  List<String> _guideList = ["app_start_1", "app_start_2", "app_start_3"];
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      // 1. 预缓存图片
      _guideList.forEach((imageName) {
        precacheImage(ImageUtils.getAssetImage(imageName, format: ImageFormat.webp), context);
      });
      // 2. 初始化页面
      _initSplash();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: _status == 0?
      const FractionallySizedBox(
        alignment: Alignment.bottomCenter,
        widthFactor: 0.33,
        heightFactor: 0.3,
        child: LoadAssetImage('logo'),
      ):
          Swiper(
            key: Key("swiper"),
              itemCount: _guideList.length,
              loop: false,
              itemBuilder: (context, index) {
                return LoadAssetImage(
                  _guideList[index],
                  key: Key(_guideList[index]),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  format: ImageFormat.webp,
              );
          })
    );
  }

  // private methods
  void _initSplash() {
    _subscription = Stream.value(1).delay(const Duration(milliseconds: 3500)).listen((event) {
      // 是否是第一次打开
      if (SpExtension.getBool(Constant.keyGuide, defaultValue: true)!) {
        SpExtension.putBool(Constant.keyGuide, false);
        // 向导页面
        _initGuide();
      } else {
        // 导航到登录页面
        _goLogin();
      }
    });
  }

  // 导航到登录页面
  void _goLogin() {
    NavigatorUtils.push(context, LoginRouter.loginPage, replace: true);
  }

  // 向导页面
  void _initGuide() {
    setState(() {
      // _status = 1时, 返回向导页面widget
      _status = 1;
    });
  }

}