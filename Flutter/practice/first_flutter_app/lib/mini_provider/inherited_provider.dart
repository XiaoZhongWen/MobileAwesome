import 'package:flutter/cupertino.dart';

class InheritedProvider<T> extends InheritedWidget {
  final T data;
  final Widget child;
  InheritedProvider({@required this.data, this.child}): super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}