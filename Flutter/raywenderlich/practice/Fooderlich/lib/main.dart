import 'package:flutter/material.dart';
import 'home.dart';
import 'fooderlich_theme.dart';

void main() {
  // 1
  runApp(const Fooderlich());
}

class Fooderlich extends StatelessWidget {
  const Fooderlich({Key key}) : super(key: key);
  // 2
  @override
  Widget build(BuildContext context) {

    final theme = FooderlichTheme.dark();

    // 3
    return MaterialApp(
      title: 'Fooderlich',
      theme: theme,
      // 4
      home: Home(),
    );
  }
}