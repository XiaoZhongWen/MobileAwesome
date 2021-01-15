
import 'dart:async';

import 'package:flutter/services.dart';

class AssassinFlutterPlugin {
  static const MethodChannel _channel =
      const MethodChannel('assassin_flutter_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<T> doRequest<T>(actionName, params) async {
    T result = await _channel.invokeMethod("doRequest", {
      "actionName": actionName,
      "params": params
    });
    return result;
  }
}
