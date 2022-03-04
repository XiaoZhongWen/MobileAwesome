import 'package:flutter/material.dart';

enum RecordStatus {
  init,
  recording,
  canceling,
  done
}

class InputStatusProvider extends ChangeNotifier {
  bool isFold = true;
  bool isKeyboard = true;
  int volume = 1;
  RecordStatus status = RecordStatus.init;

  set keyboard(bool isKeyboard) {
    this.isKeyboard = isKeyboard;
    notifyListeners();
  }

  set fold(bool isFold) {
    this.isFold = isFold;
  }

  set recordStatus(RecordStatus s) {
    status = s;
    notifyListeners();
  }

  set recordVolume(int v) {
    volume = v;
    notifyListeners();
  }
}