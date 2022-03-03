import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/service/mcs_sound_service.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_asset_image.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_button.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_title.dart';
import 'package:flutter_cloud_platform/conversation/providers/input_status_provider.dart';
import 'package:provider/provider.dart';

class InputContainerWidget extends StatefulWidget {
  const InputContainerWidget({
    Key? key,
    this.sendTextMessage,
    this.switchKeyboard,
    this.switchFoldStatus,
    this.focusNode
  }) : super(key: key);

  final ValueChanged<String>? sendTextMessage;
  final ValueChanged<bool>? switchKeyboard;
  final ValueChanged<bool>? switchFoldStatus;
  final FocusNode? focusNode;

  @override
  _InputContainerWidgetState createState() => _InputContainerWidgetState();
}

class _InputContainerWidgetState extends State<InputContainerWidget> {

  final TextEditingController _editingController = TextEditingController();

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double iconSize = 30.0;
    InputStatusProvider provider = Provider.of<InputStatusProvider>(context, listen: false);
    return Container(
      padding: EdgeInsets.symmetric(vertical: MCSLayout.smallPadding),
      decoration: const BoxDecoration(
        border: topGreyBorder,
      ),
      child: Selector<InputStatusProvider, bool>(
        selector: (_, provider) => provider.isKeyboard,
        shouldRebuild: (prev, next) => prev != next,
        builder: (_, isKeyboard, __) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  provider.keyboard = !provider.isKeyboard;
                  if (provider.isKeyboard && !(widget.focusNode?.hasFocus ?? true)) {
                    widget.focusNode?.requestFocus();
                  }
                  if (!provider.isFold) {
                    provider.fold = !provider.isFold;
                    if (widget.switchFoldStatus != null) {
                      widget.switchFoldStatus!(provider.isFold);
                    }
                  }
                },
                icon: MCSAssetImage(
                    isKeyboard?'chat/voice_input':'chat/keyboard_input',
                    width: iconSize,
                    height: iconSize
                ),
              ),
              Expanded(
                  child: isKeyboard?
                  TextField(
                    minLines: 1,
                    maxLines: 5,
                    enabled: true,
                    focusNode: widget.focusNode,
                    controller: _editingController,
                    textInputAction: TextInputAction.send,
                    onEditingComplete: () {},
                    onSubmitted: (String text) {
                      if (widget.sendTextMessage != null) {
                        widget.sendTextMessage!(text);
                      }
                      _editingController.clear();
                    },
                    decoration: const InputDecoration(
                        labelText: '输入发送内容'
                    ),
                  ):GestureDetector(
                    onLongPressStart: (_) {
                      MCSSoundService.singleton.startRecorder();
                    },
                    onLongPress: () {
                      print('onLongPress');
                    },
                    onLongPressEnd: (_) async {
                      String? path = await MCSSoundService.singleton.stopRecorder();
                      if (path != null) {
                        MCSSoundService.singleton.getDuration(path);
                      }
                    },
                    child: MCSButton(
                      label: MCSTitle('按住说话', type: MCSTitleType.btnTitleNormal,),
                      disabledColor: MCSColors.shallowGrey,
                    ),
                  )
              ),
              IconButton(
                onPressed: () {
                  provider.fold = !provider.isFold;
                  if (!provider.isFold) {
                    if (!provider.isKeyboard) {
                      provider.keyboard = true;
                    }
                    if (widget.focusNode?.hasFocus ?? false) {
                      widget.focusNode?.unfocus();
                    }
                    if (widget.switchFoldStatus != null) {
                      widget.switchFoldStatus!(provider.isFold);
                    }
                  } else {
                    if (widget.switchFoldStatus != null) {
                      widget.switchFoldStatus!(provider.isFold);
                    }
                    if (!(widget.focusNode?.hasFocus ?? true)) {
                      widget.focusNode?.requestFocus();
                    }
                  }
                },
                icon: MCSAssetImage('chat/unfold_input', width: iconSize, height: iconSize,),
              ),
            ],
          );
        },
      )
      // child: Consumer<InputStatusProvider>(
      //   builder: (_, provider, __) {
      //     if (provider.isKeyboard && _focusNode.hasFocus) {
      //       _focusNode.unfocus();
      //     }
      //     if (!provider.isFold && widget.switchFoldStatus != null) {
      //       widget.switchFoldStatus!(true);
      //     }
      //     // if (widget.switchKeyboard != null) {
      //     //   widget.switchKeyboard!(provider.isKeyboard);
      //     // }
      //     // if (provider.isFold && widget.switchFoldStatus != null) {
      //     //   widget.switchFoldStatus!(true);
      //     // }
      //     // if (!provider.isKeyboard && _focusNode.hasFocus) {
      //     //   _focusNode.unfocus();
      //     // }
      //     // if (provider.isKeyboard && !_focusNode.hasFocus) {
      //     //   _focusNode.requestFocus();
      //     // }
      //
      //     return
      //   })
    );
  }
}
