import 'dart:collection';

import 'package:first_flutter_app/Cart/Item.dart';
import 'package:first_flutter_app/mini_provider/change_notifier.dart';

class CartModel extends ChangedNotifier {
  final List<Item> _items = [];

  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  double get totalPrice => _items.fold(0, (previousValue, element) => previousValue + element.count * element.price);

  void add(Item item) {
    _items.add(item);
    notifyAllListeners();
  }
}