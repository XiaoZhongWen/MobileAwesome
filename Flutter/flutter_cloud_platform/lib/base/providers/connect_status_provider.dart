import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/service/mcs_im_service.dart';

enum ConnectStatus {
  unknown,
  connecting,
  success,
  failure,
  kickedOffline,
  userSigExpired,
  selfInfoUpdated
}

class ConnectStatusProvider extends ChangeNotifier {
  ConnectStatusProvider() {
    _init();
  }

  ConnectStatus _status = ConnectStatus.unknown;

  ConnectStatus get status => _status;

  void _init() {
    MCSIMService.singleton.initSDK(
        onConnectFailed: onConnectFailed,
        onConnectSuccess: onConnectSuccess,
        onConnecting: onConnecting,
        onKickedOffline: onKickedOffline,
        onSelfInfoUpdated: onSelfInfoUpdated,
        onUserSigExpired: onUserSigExpired
    );
  }

  void onConnecting() {
    _status = ConnectStatus.connecting;
    notifyListeners();
  }

  void onConnectSuccess() {
    _status = ConnectStatus.success;
    notifyListeners();
  }

  void onConnectFailed(int code, String error) {
    _status = ConnectStatus.failure;
    notifyListeners();
  }

  void onKickedOffline() {
    _status = ConnectStatus.kickedOffline;
    notifyListeners();
  }

  void onUserSigExpired() {
    _status = ConnectStatus.userSigExpired;
    notifyListeners();
  }

  void onSelfInfoUpdated() {
    _status = ConnectStatus.selfInfoUpdated;
    notifyListeners();
  }
}