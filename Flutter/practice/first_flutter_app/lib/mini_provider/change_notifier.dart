import 'package:flutter/cupertino.dart';

class ChangedNotifier implements Listenable {
  List listeners = [];

  @override
  void addListener(listener) {
    listeners.add(listener);
  }

  @override
  void removeListener(listener) {
    listeners.remove(listener);
  }

  void notifyAllListeners() {
    listeners.forEach((element) => element());
  }
}