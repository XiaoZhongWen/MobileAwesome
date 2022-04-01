import 'dart:typed_data';

import 'package:dio/dio.dart';

class Download {
  static final Download singleton = Download._();
  final Dio _dio = Dio();

  Download._() {}
  
  Future<Uint8List?> download(
      String url, {
        String? savePath,
        void Function(double progress)? onProgress
      }) async {
    if (savePath != null) {
      _dio.download(
          url,
          savePath,
          onReceiveProgress: (count, total) {
        double progress = count / total;
        if (onProgress != null) {
          onProgress(progress);
        }
      });
    } else {
      Options options = Options(responseType: ResponseType.bytes);
      Response response = await _dio.get(
          url,
          options: options,
          onReceiveProgress: (count, total) {
            double progress = count / total;
            if (onProgress != null) {
              onProgress(progress);
            }
          });
      if (response.statusCode == 200) {
        return Uint8List.fromList(response.data);
      } else {
        return null;
      }
    }
  }
}