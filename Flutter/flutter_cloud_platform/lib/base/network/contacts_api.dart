import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_platform.dart';
import 'package:flutter_cloud_platform/base/network/api_options.dart';
import 'package:flutter_cloud_platform/base/network/interceptors/auth_interceptor.dart';
import 'package:flutter_cloud_platform/contacts/models/contacts_category.dart';

class ContactsApi {
  final String _baseUrl = HTTP_PREFIX_APIS + HTTPDOMAIN;
  late Dio _dio;
  static final ContactsApi singleton = ContactsApi._();

  final String _contactListPath = '/address/listAll';
  final String _contactDetailPath = '/users/showOther';

  ContactsApi._() {
    BaseOptions options = baseOptions.copyWith(baseUrl: _baseUrl);
    _dio = Dio(options);
    _dio.interceptors.add(AuthInterceptor());
  }

  Future<dynamic> fetchContactList() async {
    try {
      Response response = await _dio.post(_contactListPath);
      return response;
    } on DioError catch(e) {}
  }

  // String? username;
  // String? displayName;
  // String? headUrl;
  // WorkStatus? workStatus;
  // Map<String, String>? card;
  Future<dynamic> fetchContactDetail(String userId) async {
    try {
      Response response = await _dio.post(_contactDetailPath, data: {'username':userId});
      String? card = response.data['card'];
      Map<String, dynamic>? cardMap;
      if (card != null && card.isNotEmpty) {
        cardMap = json.decode(card) as Map<String, dynamic>?;
      }
      Map<String, dynamic> map = {
        'username':response.data['username'] as String?,
        'displayName':response.data['cnname'] as String?,
        'headUrl':response.data['headUrl'] as String?,
        'card':cardMap,
        'workStatus':response.data['workStatus'] as Map<String, dynamic>?,
      };
      response.data = map;
      return response;
    } on DioError catch(e) {}
  }
}