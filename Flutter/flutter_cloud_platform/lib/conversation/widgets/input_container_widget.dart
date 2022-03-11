import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/service/mcs_sound_service.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_asset_image.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_button.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_title.dart';
import 'package:flutter_cloud_platform/conversation/providers/input_status_provider.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class InputContainerWidget extends StatefulWidget {
  const InputContainerWidget({
    Key? key,
    this.sendTextMessage,
    this.switchKeyboard,
    this.switchFoldStatus,
    this.sendAudioMessage,
    this.focusNode
  }) : super(key: key);

  final ValueChanged<String>? sendTextMessage;
  final ValueChanged<bool>? switchKeyboard;
  final ValueChanged<bool>? switchFoldStatus;
  final void Function(String path, int duration)? sendAudioMessage;
  final FocusNode? focusNode;

  @override
  _InputContainerWidgetState createState() => _InputContainerWidgetState();
}

class _InputContainerWidgetState extends State<InputContainerWidget> {

  final TextEditingController _editingController = TextEditingController();
  final double _iconSize = 30.0;
  final double _maxOffsetY = -80.0;

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: MCSLayout.smallPadding),
      decoration: const BoxDecoration(
        border: topGreyBorder,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _leftIcon(),
          Expanded(
            child: Selector<InputStatusProvider, bool>(
                selector: (_, provider) => provider.isKeyboard,
                shouldRebuild: (prev, next) => prev != next,
                builder: (_, isKeyboard, __) {
                  return isKeyboard? _textInputWidget():_audioRecordWidget();
                }
            )
          ),
          _rightIcon()
        ],
      )
    );
  }

  Widget _leftIcon() {
    InputStatusProvider provider = Provider.of<InputStatusProvider>(context, listen: false);
    return Selector<InputStatusProvider, bool>(
        selector: (_, provider) => provider.isKeyboard,
        shouldRebuild: (prev, next) => prev != next,
        builder: (_, isKeyboard, __) {
          return IconButton(
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
                width: _iconSize,
                height: _iconSize
            ),
          );
        });
  }

  Widget _rightIcon() {
    InputStatusProvider provider = Provider.of<InputStatusProvider>(context, listen: false);
    return IconButton(
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
      icon: MCSAssetImage('chat/unfold_input', width: _iconSize, height: _iconSize,),
    );
  }

  Widget _textInputWidget() {
    return TextField(
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
    );
  }

  Widget _audioRecordWidget() {
    InputStatusProvider provider = Provider.of<InputStatusProvider>(context, listen: false);
    return Selector<InputStatusProvider, RecordStatus>(
        selector: (_, provider) => provider.status,
        shouldRebuild: (prev, next) => prev != next,
        builder: (_, status, __) {
          return GestureDetector(
            onLongPressStart: (_) {
              MCSSoundService.singleton.startRecorder();
              MCSSoundService.singleton.onVolume = (volume) {
                provider.recordVolume = volume ~/ 20 + 1;
              };
              provider.recordStatus = RecordStatus.recording;
            },
            onLongPressMoveUpdate: (detail) {
              Offset offset = detail.localOffsetFromOrigin;
              if (offset.dy < _maxOffsetY) {
                // 取消录音
                provider.recordStatus = RecordStatus.canceling;
              } else {
                provider.recordStatus = RecordStatus.recording;
              }
            },
            onLongPressEnd: (detail) async {
              provider.recordStatus = RecordStatus.done;
              Offset offset = detail.localPosition;
              if (offset.dy > _maxOffsetY) {
                String? path = await MCSSoundService.singleton.stopRecorder();
                if (path != null) {
                  int duration = await MCSSoundService.singleton.getDuration(path);
                  if (duration == 0) {
                    // tip: record duration too short
                    showToast('录制时间过短');
                  } else {
                    if (widget.sendAudioMessage != null) {
                      widget.sendAudioMessage!(path, duration);
                    }
                  }
                }
              } else {
                MCSSoundService.singleton.stopRecorder(cancel: true);
              }
            },
            child: MCSButton(
              label: MCSTitle(
                status == RecordStatus.recording? '松开结束': '按住说话',
                type: MCSTitleType.btnTitleNormal,),
              disabledColor: status == RecordStatus.recording? MCSColors.lightGrey: MCSColors.shallowGrey,
            ),
          );
        }
    );
  }
}
