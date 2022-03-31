import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_cloud_platform/base/cache/mcs_memory_cache.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_message_type.dart';
import 'package:flutter_cloud_platform/base/dao/message_dao.dart';
import 'package:flutter_cloud_platform/base/network/clouddisk_api.dart';
import 'package:flutter_cloud_platform/base/service/mcs_im_service.dart';
import 'package:flutter_cloud_platform/base/service/mcs_image_service.dart';
import 'package:flutter_cloud_platform/base/service/mcs_sound_service.dart';
import 'package:flutter_cloud_platform/conversation/models/mcs_message.dart';
import 'package:flutter_cloud_platform/base/extension/string_extension.dart';
import 'package:mcs_photo_picker/m_file.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

enum MessageStatusType {
  audioPlay,
  videoPlay,
  send,
  progress
}

class IMProvider extends ChangeNotifier {
  IMProvider() {
    _init();
  }

  /*
  * 当前会话中对方的账号
  * */
  String? _peerID;

  set peerID(String id) {
    _peerID = id;
  }

  List<MCSMessage> fetchMessageList(int offset) {
    List<MCSMessage> list = [];
    List<MCSMessage> cache = _datasource[_peerID]?.values.toList() ?? [];
    cache.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    int index = cache.length - (offset + MessageDao.limit);
    if (index >= 0) {
      cache.removeRange(0, index);
    }
    list.addAll(addTime(cache).reversed);
    return list;
  }

  final Map<String, Map<String, MCSMessage>> _datasource = {};
  final Map<String, Map<MessageStatusType, int>> _statusMap = {};

  void _init() {
    MCSIMService.singleton.addEventListener(
      onRecvNewMessage:onRecvNewMessage,
      onSendMessageProgress:onSendMessageProgress
    );
  }

  int fetchMessageStatus(String msgId, MessageStatusType type) {
    Map<MessageStatusType, int>? map = _statusMap[msgId];
    if (map == null) {
      _statusMap[msgId] = {
        type: 0
      };
      return 0;
    } else {
      int? status = map[type];
      if (status == null) {
        map[type] = 0;
        return 0;
      } else {
        return status;
      }
    }
  }

  List<Map<String, String?>> fetchAllImageMessage() {
    List<Map<String, String?>> list = [];
    List<MCSMessage> cache = _datasource[_peerID]?.values.toList() ?? [];
    cache.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    for (var message in cache) {
      if (message.type == MCSMessageType.image) {
        list.add({
          fileNameKey:message.imageElem?.fileName,
          urlKey:message.imageElem?.url
        });
      }
    }
    return list;
  }

  void updateMessageStatus(String msgId, MessageStatusType type, {int? value}) {
    Map<MessageStatusType, int>? map = _statusMap[msgId];
    if (map == null) {
      _statusMap[msgId] = {
        type: value ?? 1
      };
    } else {
      int? status = map[type];
      if (status == null) {
        map[type] = value ?? 1;
      } else {
        map[type] = value ?? status + 1;
      }
    }
    notifyListeners();
  }

  Future<void> loadMessageList(int offset) async {
    if (_peerID == null || _peerID!.isEmpty) {
      return;
    }
    List<MCSMessage> cache = _datasource[_peerID]?.values.toList() ?? [];
    if (cache.length <= offset) {
      MessageDao dao = MessageDao();
      List<MCSMessage> messages = await dao.fetchMessages(_peerID!, offset);
      addMessages(messages);
    } else {
      if (offset != 0) {
        notifyListeners();
      }
    }
  }

  List<MCSMessage> addTime(List<MCSMessage> list) {
    List<MCSMessage> messages = [];
    double timestamp = 0.0;
    for (MCSMessage msg in list) {
      if (timestamp == 0.0) {
        // 第一条消息前插入时间消息
        messages.add(MCSMessage.time(msg.timestamp));
      } else if (msg.timestamp - timestamp > 60.0) {
        // 超过一分钟插入时间消息
        messages.add(MCSMessage.time(msg.timestamp));
      }
      messages.add(msg);
      timestamp = msg.timestamp;
    }
    return messages;
  }

  void addMessages(List<MCSMessage> messages) {
    if (_peerID == null || _peerID!.isEmpty) {
      return;
    }
    Map<String, MCSMessage> map = {};
    if (_datasource[_peerID] == null) {
      _datasource[_peerID!] = map;
    } else {
      map = _datasource[_peerID!]!;
    }
    List<String> keys = map.keys.toList();
    int count = 0;
    for (var msg in messages) {
      if (!keys.contains(msg.msgID)) {
        map[msg.msgID] = msg;
        count++;
      }
    }
    if (count > 0) {
      notifyListeners();
    }
  }

  /*
  * 发送消息
  * receiver: 接收方id
  * type: 消息类型
  * text: text/plain 消息内容
  * */
  void sendMessage(
      String receiver,
      MCSMessageType type, {
        String? receiverName,
        String? text,
        String? localPath,
        int? duration,
        MFile? file
      }) {
    switch (type) {
      case MCSMessageType.text: {
        if (text != null) {
          _sendTextMessage(receiver, text, receiverName: receiverName);
        }
        break;
      }
      case MCSMessageType.audio: {
        _sendAudioMessage(receiver, localPath, duration, receiverName: receiverName);
        break;
      }
      case MCSMessageType.image: {
        _sendImageMessage(receiver, file, receiverName: receiverName);
        break;
      }
    }
  }

  /*
  * 发送文本消息
  * receiver: 接收方id
  * type: 消息类型
  * */
  void _sendTextMessage(
      String receiver,
      String text, {
        String? receiverName
      }) async {
    String? sender = MCSMemoryCache.singleton.fetchAccountId();
    String? senderName = MCSMemoryCache.singleton.fetchAccountDisplayName();
    Map<String, dynamic> map = {
      'type': plainText,
      'header': {
        'sender':sender,
        'receiver':receiver,
        'senderName':senderName,
        'receiverName':receiverName,
      },
      'data': {
        'text':text
      }
    };
    MCSMessage? message = await MCSIMService.singleton.sendMessage(receiver, json.encode(map));
    if (message != null) {
      addMessages([message]);
    }
  }

  void _sendAudioMessage(
      String receiver,
      String? path,
      int? duration, {
        String? receiverName
      }) async {
    if (path == null || duration == null) {
      return;
    }
    _sendFileMessage(
        receiver,
        audioText,
        receiverName: receiverName,
        path: path,
        duration: duration);
  }

  void _sendImageMessage(
      String receiver,
      MFile? file, {
        String? receiverName
      }) async {
    if (file == null) {
      return;
    }
    // 1. 生成预览图
    MFile mFile = await MCSImageService.singleton.generateThumbnail(file);
    // 2. 发送消息
    // 将图片的原始宽高改为经过计算得到的显示在消息界面图片消息视图的宽高
    file.width = mFile.width;
    file.height = mFile.height;
    _sendFileMessage(
        receiver,
        imageText,
        receiverName: receiverName,
        file: file);
  }

  void _sendFileMessage(
      String receiver,
      String type, {
        String? receiverName,
        String? path,
        int? duration,
        MFile? file}
      ) {
    String? sender = MCSMemoryCache.singleton.fetchAccountId();
    String? senderName = MCSMemoryCache.singleton.fetchAccountDisplayName();

    String? filePath;
    Map<String, dynamic> data = {};
    switch (type) {
      case audioText: {
        if (path != null) {
          String fileName = path.split('/').last;
          filePath = path;
          data = {
            'duration':duration,
            'fileName':fileName
          };
        }
        break;
      }
      case imageText: {
        filePath = file?.path;
        String? fileName = filePath?.split('/').last;
        data = {
          'fileName':fileName,
          'width':file?.width,
          'height':file?.height,
        };
        break;
      }
      default: {

      }
    }

    Map<String, dynamic> map = {
      'type': type,
      'header': {
        'sender':sender,
        'receiver':receiver,
        'senderName':senderName,
        'receiverName':receiverName,
      },
      'data': data
    };

    if (filePath == null) {
      return;
    }

    MCSMessage? message = MCSIMService.singleton.createMessage(map);
    if (message != null) {
      addMessages([message]);
      CloudDiskApi.singleton.sendFile(
          message.msgID,
          receiver,
          filePath,
          onSendProgress: (progress) {
            if (message.type == MCSMessageType.image) {
              int value = (progress * 100).toInt();
              updateMessageStatus(message.msgID, MessageStatusType.progress, value: value);
            }
      }).then((response) async {
        String? id = response.extra['id'];
        String? receiver = response.extra['receiver'];
        String url = response.data['url'];
        int expires = response.data['expires'];
        if (id != null && receiver != null) {
          Map<String, MCSMessage>? map = _datasource[receiver];
          MCSMessage? msg = map?[id];
          if (msg != null) {
            switch (msg.type) {
              case MCSMessageType.audio: {
                msg.audioElem?.url = url;
                msg.audioElem?.expires = expires;
                String prev = msg.audioElem!.fileName!;
                String next = url.md5String()+'.amr';
                msg.audioElem?.fileName = next;
                MCSSoundService.singleton.modifyFileName(prev, next);
                break;
              }
              case MCSMessageType.image: {
                msg.imageElem?.url = url;
                msg.imageElem?.expires = expires;
                String prev = msg.imageElem!.fileName!;
                String next = url.md5String();
                msg.imageElem?.fileName = next;
                MCSImageService.singleton.modifyFileName(prev, next);
                break;
              }
            }

            Map<String, dynamic> body = msg.toBody();
            MCSMessage? newMsg = await MCSIMService.singleton.sendMessage(receiver, json.encode(body));
            if (newMsg != null) {
              updateMessageStatus(id, MessageStatusType.send);
              Map<String, MCSMessage>? map = _datasource[receiver];
              if (map != null && map[id] != null) {
                map.remove(id);
                map[message.msgID] = message;
                MessageDao dao = MessageDao();
                dao.deleteMessage(id);
              }
            }
          }
        }
      });
    }
  }

  void onRecvNewMessage(MCSMessage msg) {
    addMessages([msg]);
  }

  void onSendMessageProgress(String msgID, int progress) {

  }
}