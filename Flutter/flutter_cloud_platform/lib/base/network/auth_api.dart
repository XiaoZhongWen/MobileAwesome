import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_cloud_platform/base/cache/mcs_memory_cache.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_platform.dart';
import 'package:flutter_cloud_platform/base/dao/account_dao.dart';
import 'package:flutter_cloud_platform/login/models/account.dart';
import 'api_options.dart';

class AuthApi {
  final String _baseUrl = HTTP_PREFIX_OPENAPI + HTTPDOMAIN;
  late Dio _dio;
  static final singleton = AuthApi._();

  final String _loginPath = '/mauth/oauth2/login';

  AuthApi._() {
    BaseOptions options = baseOptions.copyWith(baseUrl: _baseUrl);
    _dio = Dio(options);
  }

  Future<Account?> login(String userId, String password) async {
    String uid = userId + '@' + DOMAIN;
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$uid:$password'));
    _dio.options.headers = {
      'Authorization':basicAuth
    };
    try {
      Response response = await _dio.post(_loginPath);
      bool success = response.statusCode == 200;
      if (success) {
        Map<String, Object?> json = {
          'userId':userId,
          'password':password,
          'nickname':response.data['cnname'],
          'headUrl':response.data['headUrl'],
          'accessToken':response.data['access_token'],
          'refreshToken':response.data['refresh_token'],
          'expire':response.data['expires_in'],
        };

        int timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
        MCSMemoryCache.singleton.store(accessTokenKey, response.data['access_token']);
        MCSMemoryCache.singleton.store(expireKey, response.data['expires_in'] + timestamp);

        Account account = Account.fromJson(json);
        AccountDao dao = AccountDao();
        dao.saveAccount(account);
        return account;
      }
      return null;
    } on DioError catch(e) {}
  }
}