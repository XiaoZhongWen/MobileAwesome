import 'package:dio/dio.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_platform.dart';
import 'package:flutter_cloud_platform/base/network/api_options.dart';
import 'package:flutter_cloud_platform/base/network/interceptors/auth_interceptor.dart';

class CloudDiskApi {
  final String _baseUrl = HTTP_PREFIX_CLOUDDISK + HTTPDOMAIN;
  late Dio _dio;
  static final CloudDiskApi singleton = CloudDiskApi._();

  final String _sendFile = '/disk/recent/sendFile';

  CloudDiskApi._() {
    BaseOptions options = baseOptions.copyWith(baseUrl: _baseUrl);
    _dio = Dio(options);
    _dio.interceptors.add(AuthInterceptor());
  }

  Future<dynamic> sendFile(
      String id,
      String receiver,
      String path, {
        void Function(double percent)? onSendProgress
      }) async {
    FormData data = FormData.fromMap({
      'file': await MultipartFile.fromFile(path),
      'receiver': receiver,
      'needSave': false
    });
    try {
      Response response = await _dio.post(
          _sendFile,
          data: data,
          onSendProgress: (int send, int total) {
            double progress = send / total;
            if (onSendProgress != null) {
              onSendProgress(progress);
            }
          });
      response.extra = {'id':id, 'receiver': receiver};
      return response;
    } on DioError catch(e) {}
  }
}