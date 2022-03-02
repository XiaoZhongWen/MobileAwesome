import 'package:flutter/material.dart';

class InputStatusProvider extends ChangeNotifier {
  bool isFold = true;
  bool isKeyboard = true;

  set keyboard(bool isKeyboard) {
    this.isKeyboard = isKeyboard;
    notifyListeners();
  }

  set fold(bool isFold) {
    this.isFold = isFold;
  }
}