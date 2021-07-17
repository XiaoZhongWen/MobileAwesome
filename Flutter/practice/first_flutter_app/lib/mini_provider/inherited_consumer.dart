import 'package:first_flutter_app/mini_provider/change_notifier_provider.dart';
import 'package:flutter/cupertino.dart';

class InheritedConsumer<T> extends StatelessWidget {
  final Widget Function(BuildContext context, T value) builder;
  InheritedConsumer({Key key, @required this.builder}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return builder(context, ChangeNotifierProvider.of<T>(context));
  }
}