import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/network/download.dart';
import 'package:flutter_cloud_platform/base/service/mcs_image_service.dart';
import 'package:flutter_cloud_platform/routes/mcs_navigator.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:oktoast/oktoast.dart';
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

  PageController? _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Icons.devices_other;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black
        ),
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height
        ),
        child: Stack(
          children: [
            GestureDetector(
              onLongPress: () {
                _showActionSheet();
              },
              onTap: () {
                MCSNavigator.pop(context);
              },
              child: PhotoViewGallery.builder(
                  pageController: _pageController,
                  itemCount: widget.datasource.length,
                  scrollPhysics: const BouncingScrollPhysics(),
                  builder: _buildItem
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  _showActionSheet();
                },
                child: const Icon(Icons.more_horiz, color: Colors.white,),
              )
            )
          ],
        )
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    Map<String, String?> map = widget.datasource[index];
    String? fileName = map[fileNameKey];
    String? url = map[urlKey];

    File? file;
    String tag = const Uuid().v1();
    if (fileName != null) {
      String path = MCSImageService.singleton.pathForOriginal(fileName);
      file = File(path);
    }
    ImageProvider? provider;
    if (file?.existsSync() ?? false) {
      provider = FileImage(file!);
      tag = fileName!;
    } else {
      NetworkImage(url!);
      tag = url.md5String();
    }

    return PhotoViewGalleryPageOptions(
      imageProvider: provider,
      heroAttributes: PhotoViewHeroAttributes(tag: tag),
    );
  }

  void _showActionSheet() {
    Widget sheet = CupertinoActionSheet(
      cancelButton: CupertinoActionSheetAction(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('取消'),
      ),
      actions: [
        CupertinoActionSheetAction(
            onPressed: _save,
            child: const Text('保存到相册')
        ),
        CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('发送给好友')
        )
      ],
    );

    showCupertinoModalPopup(
        context: context,
        builder: (_) {
          return sheet;
        }
    );
  }

  void _save() async {
    int? index = _pageController?.page?.toInt();
    if (index != null) {
      Map<String, String?> map = widget.datasource[index];
      String? fileName = map[fileNameKey];
      String? url = map[urlKey];

      File? file;
      bool exist = true;
      if (fileName != null) {
        String path = MCSImageService.singleton.pathForOriginal(fileName);
        file = File(path);
        if (file.existsSync()) {
          exist = false;
          ImageGallerySaver.saveFile(path).then((value) {
            showToast('保存成功');
            Navigator.pop(context);
          });
        }
      }
      if (!false) {
        Uint8List? data = await Download.singleton.download(url!);
        if (data != null) {
          ImageGallerySaver.saveImage(data);
          showToast('保存成功');
          Navigator.pop(context);
        }
      }
    }
  }
}
