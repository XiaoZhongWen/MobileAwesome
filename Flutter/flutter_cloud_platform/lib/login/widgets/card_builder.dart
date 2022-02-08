import 'package:flutter/material.dart';
import 'package:another_transformer_page_view/another_transformer_page_view.dart';
import 'cards/cards.dart';

enum CardType { loginCard, signupCard }

class CardBuilder extends StatefulWidget {
  const CardBuilder({
    Key? key,
    this.usernameValidator,
    this.passwordValidator,
    this.padding = const EdgeInsets.all(0)
  }) : super(key: key);

  final EdgeInsets padding;
  final FormFieldValidator<String>? usernameValidator;
  final FormFieldValidator<String>? passwordValidator;

  @override
  _CardBuilderState createState() => _CardBuilderState();
}

class _CardBuilderState extends State<CardBuilder> with TickerProviderStateMixin {

  int _pageIndex = 0;
  final List<CardType> _cards = [CardType.loginCard, CardType.signupCard];

  @override
  void initState() {
    super.initState();
  }

  Widget _changeToCard(BuildContext context, int index) {
    CardType type = _cards[index];
    switch (type) {
      case CardType.loginCard: {
        return LoginCard(
          usernameValidator: widget.usernameValidator,
          passwordValidator: widget.passwordValidator,
        );
      }
      case CardType.signupCard: {
        break;
      }
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    Widget current = Container(
      width: deviceSize.width,
      height: deviceSize.height,
      padding: widget.padding,
      child: TransformerPageView(
        physics: const NeverScrollableScrollPhysics(),
        index: _pageIndex,
        itemCount: _cards.length,
        itemBuilder: (BuildContext context, int index) {
          return Align(
            alignment: Alignment.topCenter,
            child: _changeToCard(context, index),
          );
        },
      )
    );
    return current;
  }
}
