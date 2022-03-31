import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MCSLoading extends StatelessWidget {
  MCSLoading(this.progress, {Key? key}) : super(key: key);

  int progress;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: progress != 100 && progress != 0,
      child: Column(
        children: [
          const CupertinoActivityIndicator(radius: 8),
          Text(
              progress.toString() + '%',
              style: const TextStyle(color: Colors.white)
          )
        ],
      ),
    );
  }
}
