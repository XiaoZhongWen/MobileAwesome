import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:mcs_photo_picker/mcs_photo_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:mcs_photo_picker/m_file.dart';

class MCSImageService {
  static final MCSImageService singleton = MCSImageService._();
  final String _imageCacheDirName = 'image';
  final String _thumbnailCacheDirName = 'thumbnail';
  final int minWidth = 640;
  final int minHeight = 320;
  final int thumbnailMaxWidth = 150;
  final int thumbnailMaxHeight = 150;
  final int thumbnailMinWidth = 54;
  final int thumbnailMinHeight = 42;
  final int quality = 50;
  final McsPhotoPicker _imagePicker = McsPhotoPicker();
  late String _rootDirPath;
  late String _thumbnailDirPath;

  MCSImageService._();

  void startService() async {
    Directory dir = await getApplicationDocumentsDirectory();
    _rootDirPath = join(dir.path, _imageCacheDirName);
    _thumbnailDirPath = join(dir.path, _thumbnailCacheDirName);
    Directory imageDir = Directory(_rootDirPath);
    bool isExist = await imageDir.exists();
    if (!isExist) {
      await imageDir.create();
    }
    Directory thumbnailDir = Directory(_thumbnailDirPath);
    isExist = await thumbnailDir.exists();
    if (!isExist) {
      await thumbnailDir.create();
    }
  }

  void uploadImage(String path, {bool isCompress = false}) async {
    String filePath = path;
    if (isCompress) {
      filePath = (await compressImages([path]))[0];
    }
    // CloudDiskApi.singleton.sendFile(id, receiver, filePath);
  }

  Future<List<String>> uploadImages(List<String> paths, {bool isCompress = false}) async {
    List<String> urls = [];
    List<String> filePaths = List.from(paths);
    if (isCompress) {
      filePaths.clear();
      List<String> list = await compressImages(paths);
      filePaths.addAll(list);
    }
    return urls;
  }

  Future<List<String>> compressImages(List<String> paths) async {
    List<String> imagePaths = [];
    for (String path in paths) {
      String filename = path.split('/').last;
      Uint8List? data = await FlutterImageCompress.compressWithFile(
          path,
          minWidth: minWidth,
          minHeight: minHeight,
          quality: quality
      );
      if (data != null) {
        String filePath = join(_rootDirPath, filename);
        Uri uri = Uri.file(filePath);
        File file = File.fromUri(uri);
        if (file.existsSync()) {
          file.deleteSync();
        }
        file.writeAsBytesSync(data);
        imagePaths.add(filePath);
      }
    }
    return imagePaths;
  }

  Future<MFile> generateThumbnail(MFile mFile) async {
    int width = mFile.width ?? thumbnailMinWidth;
    int height = mFile.height ?? thumbnailMinHeight;
    double ratio = width / height;
    if (width > thumbnailMaxWidth) {
      width = thumbnailMaxWidth;
      height = width ~/ ratio;
    }
    if (height > thumbnailMaxHeight) {
      height = thumbnailMaxHeight;
      width = (height * ratio).toInt();
    }
    if (width < thumbnailMinWidth) {
      width = thumbnailMinWidth;
      height = width ~/ ratio;
    }
    if (height < thumbnailMinHeight) {
      height = thumbnailMinHeight;
      width = (height * ratio).toInt();
    }
    String filePath = await _imagePicker.reRenderImage(mFile.path, width, height);
    MFile file = MFile(filePath, width: width, height: height);
    return file;
  }

  void modifyFileName(String prev, String next) {
    File file = File(join(_rootDirPath, prev));
    if (file.existsSync()) {
      // 更新原图的名字
      file.rename(join(_rootDirPath, next));
    }
    file = File(join(_thumbnailDirPath, prev));
    if (file.existsSync()) {
      // 更新缩略图的名字
      file.rename(join(_thumbnailDirPath, next));
    }
  }

  String pathForThumbnail(String fileName) {
    return _thumbnailDirPath + '/' + fileName;
  }
}