
import 'dart:async';

import 'package:flutter/services.dart';
import 'm_file.dart';

enum MCSPhotoPickerSelectedType {
  photo,
  video,
  photoAndVideo
}

extension on MCSPhotoPickerSelectedType {
  int get value => [0 ,1, 2][index];
}

class McsPhotoPicker {
  static const MethodChannel _channel = MethodChannel('mcs_photo_picker');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<Map<String, dynamic>> pickMultiImage({
    MCSPhotoPickerSelectedType type = MCSPhotoPickerSelectedType.photoAndVideo,
    bool videoCanEdit = false,
    bool showOriginalBytes = false
  }) async {
    Map<dynamic, dynamic> result = await _channel.invokeMethod('pickMultiImage', {
      'type': type.value,
      'videoCanEdit': videoCanEdit,
      'showOriginalBytes': showOriginalBytes
    });
    bool? original = result['original'] as bool?;
    List<MFile> images = [];
    List<MFile> videos = [];
    if (result['images'] is List) {
      for (Map? map in result['images']) {
        if (map != null && map is Map) {
          MFile mFile = MFile.fromJson(map);
          images.add(mFile);
        }
      }
    }
    if (result['videos'] is List) {
      for (Map? map in result['videos']) {
        if (map != null && map is Map) {
          MFile mFile = MFile.fromJson(map);
          videos.add(mFile);
        }
      }
    }
    return {
      'original':original,
      'images':images,
      'videos':videos
    };
  }

  Future<String> reRenderImage(String path, int width, int height) async {
    String result = await _channel.invokeMethod('reRenderImage', {
      'path':path,
      'width':width,
      'height':height
    });
    return result;
  }

  Future<MFile> takePicture() async {
    Map<dynamic, dynamic> result = await _channel.invokeMethod('takePicture');
    MFile mFile = MFile.fromJson(result);
    return mFile;
  }

}
