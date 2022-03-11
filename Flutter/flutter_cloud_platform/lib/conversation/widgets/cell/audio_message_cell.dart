import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/service/mcs_sound_service.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_asset_image.dart';

class AudioMessageCell extends StatefulWidget {
  AudioMessageCell(
      this.msgId,
      this.isComing,
      this.second,
      this.fileName,
      this.url, {Key? key}) : super(key: key);

  String msgId;
  bool isComing;
  int second;
  String fileName;
  String url;

  @override
  _AudioMessageCellState createState() => _AudioMessageCellState();
}

class _AudioMessageCellState extends State<AudioMessageCell> with SingleTickerProviderStateMixin {

  late Animation<int> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
    _animation = IntTween(begin: 1, end: 3).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MCSSoundService.singleton.isPlaying(key: widget.msgId)) {
      _animationController.repeat();
    } else {
      _animationController.reset();
    }
    int second = widget.second;
    bool isComing = widget.isComing;
    Widget gap = SizedBox(width: 3.0 * second);
    AnimatedBuilder animatedBuilder = AnimatedBuilder(
      animation: _animation,
      builder: (_, child) {
        int step = _animation.value;
        if (!_animationController.isAnimating) {
          step = 3;
        }
        return MCSAssetImage(
          isComing? '/chat/audio_left_playing_step$step': '/chat/audio_right_playing_step$step',
          width: 15,
          height: 15,
        );
      },
    );
    List<Widget> list = [
      animatedBuilder,
      MCSLayout.hGap3,
      Text('$second"')
    ];

    if (!isComing) {
      list = list.reversed.toList();
      list.insert(0, gap);
    } else {
      list.add(gap);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: list,
        ),
        Visibility(
          visible: isComing,
          child: MCSAssetImage('/chat/red_dot', width: 9.0, height: 9.0,),
        )
      ],
    );
  }
}
