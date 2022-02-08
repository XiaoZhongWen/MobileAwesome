import 'package:flutter/material.dart';

class MCSGradientBox extends StatelessWidget {
  const MCSGradientBox({
    Key? key,
    required this.colors,
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight
  }) : super(key: key);

  final List<Color> colors;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: begin,
          end: end
        )
      ),
      child: const SizedBox.expand(),
    );
  }
}
