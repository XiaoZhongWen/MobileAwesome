import 'package:dio/dio.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_setting.dart';
import '../constant/mcs_constant.dart';

const String HTTP_PREFIX_DEV = 'https://dev';
const String HTTP_PREFIX_APIS = 'https://apis';
const String HTTP_PREFIX_SHARE = 'https://share';
const String HTTP_PREFIX_OPENAPI = 'https://openapi';
const String HTTP_PREFIX_CLOUDDISK = 'https://clouddisk';

final baseOptions = BaseOptions(
  connectTimeout: inProduction?connectTimeout:10 * connectTimeout,
  receiveTimeout: inProduction?receiveTimeout:10 * receiveTimeout,
  sendTimeout: inProduction?sendTimeout:10 * sendTimeout
);