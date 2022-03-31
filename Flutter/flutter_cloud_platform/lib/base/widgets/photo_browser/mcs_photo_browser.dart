import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/service/mcs_image_service.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_cloud_platform/base/extension/string_extension.dart';

class MCSPhotoBrowser extends StatefulWidget {
  MCSPhotoBrowser({Key? key, required this.index, required this.datasource}) : super(key: key);

  int index;
  List<Map<String, String?>> datasource;

  @override
  _MCSPhotoBrowserState createState() => _MCSPhotoBrowserState();
}

class _MCSPhotoBrowserState extends State<MCSPhotoBrowser> {
  @override
  Widget build(BuildContext context) {
    return PhotoViewGallery.builder(
        itemCount: widget.datasource.length,
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          Map<String, String?> map = widget.datasource[index];
          String? fileName = map[fileNameKey];
          String? url = map[urlKey];

          File? file;
          String tag = const Uuid().v1();
          if (fileName != null) {
            String path = MCSImageService.singleton.pathForThumbnail(fileName);
            file = File(path);

          }
          ImageProvider? provider;
          if (file?.existsSync() ?? false) {
            provider = FileImage(file!);
            tag = fileName!;
          } else {
            NetworkImage(url!);
            tag = url!.md5String();
          }

          PhotoViewGalleryPageOptions(
            imageProvider: provider,
            heroAttributes: PhotoViewHeroAttributes(tag: tag);
          );
        }
    );
  }
}
