import 'package:first_flutter_app/Cart/CartModel.dart';
import 'package:first_flutter_app/Cart/Item.dart';
import 'package:first_flutter_app/mini_provider/change_notifier_provider.dart';
import 'package:first_flutter_app/mini_provider/inherited_consumer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProviderRouter extends StatefulWidget {
  _ProviderRouterState createState() => _ProviderRouterState();
}

class _ProviderRouterState extends State<ProviderRouter> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ChangeNotifierProvider<CartModel>(
        data: CartModel(),
        child: Builder(builder: (context) {
          return Column(
            children: [
              SizedBox.fromSize(size: Size(10,100),),
              InheritedConsumer<CartModel>(builder: (context, cart) {
                return Text("总价: ${cart.totalPrice}");
              }),
              Builder(builder: (context) {
                return RaisedButton(
                  onPressed: () {
                    ChangeNotifierProvider.of<CartModel>(context).add(Item(title: "iPhone", price: 7000, count: 1));
                  },
                  child: Text("添加商品"),
                );
              })
            ],
          );
        })
      ),
    );
  }
}