import 'package:dio/dio.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_platform.dart';
import 'package:flutter_cloud_platform/base/network/api_options.dart';

class ContactsApi {
  final String _baseUrl = HTTP_PREFIX_APIS + HTTPDOMAIN + '/address/';
  late Dio _dio;
  static final ContactsApi singleton = ContactsApi._();

  final String _contactListPath = 'listAll';

  ContactsApi._() {
    BaseOptions options = baseOptions.copyWith(baseUrl: _baseUrl);
    _dio = Dio(options);
  }

  Future<dynamic> fetchContactList() async {
    Response response = await _dio.post(_contactListPath);
    return response;
  }
}