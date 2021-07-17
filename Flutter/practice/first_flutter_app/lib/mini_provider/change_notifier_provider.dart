import 'package:first_flutter_app/mini_provider/change_notifier.dart';
import 'package:first_flutter_app/mini_provider/inherited_provider.dart';
import 'package:flutter/cupertino.dart';

class ChangeNotifierProvider<T extends ChangedNotifier> extends StatefulWidget {

  final T data;
  final Widget child;

  ChangeNotifierProvider({Key key, @required this.data, this.child}): super(key: key);

  static T of<T>(BuildContext context) {
    var provider = context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>();
    return provider.data;
  }

  @override
  _ChangeNotifierProviderState<T> createState() => _ChangeNotifierProviderState<T>();
}

class _ChangeNotifierProviderState<T extends ChangedNotifier> extends State<ChangeNotifierProvider<T>> {

  void update() {
    setState(() {

    });
  }

  @override
  void initState() {
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void didUpdateWidget(ChangeNotifierProvider<T> oldWidget) {
    if (widget != oldWidget) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider<T>(
      data: widget.data,
      child: widget.child,
    );
  }
}