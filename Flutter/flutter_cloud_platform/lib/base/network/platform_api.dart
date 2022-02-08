import 'dart:convert';

import 'package:dio/dio.dart';
import 'api_options.dart';
import '../constant/mcs_platform.dart';

class PlatformApi {
  final String _baseUrl = HTTP_PREFIX_DEV + HTTPDOMAIN + '/plat/';
  late Dio _dio;

  static final PlatformApi singleton = PlatformApi._();

  PlatformApi._() {
    BaseOptions options = baseOptions.copyWith(baseUrl: _baseUrl);
    _dio = Dio(options);
  }

  Future<dynamic> fetchPlatformVisual() async {
    String path = 'v2/theme/source';
    Map params = {
      'guid': GUID,
      'osType': 1,
      'configVersion': 0,
      'themeVersion': 0
    };
    Response response = await _dio.post(path, data: params);
    return response;
  }
}

