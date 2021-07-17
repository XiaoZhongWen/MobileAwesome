import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter_deer/res/constants.dart';

/**
 * 1. 在 Flutter 中可以通过 FlutterError 来捕获到运行期间的错误，包括构建期间、布局期间和绘制期间。
 * 2. runZonedGuarded 则是使用 Zone.fork 创建一片新的区域去运行代码逻辑，也就是 runApp，当遇到错误时会执行其回调函数 onError，其次如果在项目使用了 Zone.current.handleUncaughtError 也会将错误抛出执行 onError 逻辑
 */
void handleError(void body) {
  FlutterError.onError = (FlutterErrorDetails details) {
    if (!Constant.inProduction) {
      /// 非生产环境将错误信息输出的控制台
      FlutterError.dumpErrorToConsole(details);
    } else {
      Zone.current.handleUncaughtError(details.exception, details.stack!);
    }
  };

  runZonedGuarded(() => body, (Object error, StackTrace stack) async {
    await _reportError(error, stack);
  });
}

Future<void> _reportError(Object error, StackTrace stack) async {
  if (!Constant.inProduction) {
    debugPrintStack(stackTrace: stack, label: error.toString(), maxFrames: 100);
  } else {
    /// 将异常信息收集并上传到服务器。可以直接使用类似`flutter_bugly`插件处理异常上报。
  }
}