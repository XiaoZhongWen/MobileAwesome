import 'package:dio/dio.dart';
import 'package:flutter_cloud_platform/base/cache/mcs_memory_cache.dart';
import 'package:flutter_cloud_platform/base/dao/account_dao.dart';
import 'package:flutter_cloud_platform/base/network/auth_api.dart';
import 'package:flutter_cloud_platform/login/models/account.dart';

class AuthInterceptor extends Interceptor {

  final String _invalidateToken = 'token无效，请重新获取token!';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String accessToken = MCSMemoryCache.singleton.fetchAccessToken();
    int expire = MCSMemoryCache.singleton.fetchExpire();
    int timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    if (timestamp > expire) {
      // accessToken过期, 重新获取accessToken
      AccountDao dao = AccountDao();
      Account? account = await dao.fetchLastTimeAccount();
      String userId = account?.userId ?? '';
      String password = account?.password ?? '';
      if (userId.isNotEmpty && password.isNotEmpty) {
        account = await AuthApi.singleton.login(userId, password);
        accessToken = account?.accessToken ?? '';
        if (accessToken.isNotEmpty) {
          // 添加认证
          String auth = 'Bearer ' + accessToken;
          options.headers['Authorization'] = auth;
        }
      }
    } else {
      // 添加认证
      String auth = 'Bearer ' + accessToken;
      options.headers['Authorization'] = auth;
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(response);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    FormatException exception = err.error;
    String source = (exception.source as String?) ?? '';
    if (source == _invalidateToken) {
      // 重新获取accessToken
      AccountDao dao = AccountDao();
      Account? account = await dao.fetchLastTimeAccount();
      String userId = account?.userId ?? '';
      String password = account?.password ?? '';
      if (userId.isNotEmpty && password.isNotEmpty) {
        account = await AuthApi.singleton.login(userId, password);
        String accessToken = account?.accessToken ?? '';
        if (accessToken.isNotEmpty) {
          // 添加认证
          String auth = 'Bearer ' + accessToken;
          RequestOptions requestOptions = err.requestOptions;
          requestOptions.headers['Authorization'] = auth;
          BaseOptions baseOptions = BaseOptions(baseUrl: requestOptions.baseUrl);
          Dio dio = Dio(baseOptions);
          Options? options = Options(
              method: requestOptions.method,
              sendTimeout: requestOptions.sendTimeout,
              receiveTimeout: requestOptions.receiveTimeout,
              extra: requestOptions.extra,
              headers: requestOptions.headers,
              responseType: requestOptions.responseType,
              contentType: requestOptions.contentType,
              validateStatus: requestOptions.validateStatus,
              receiveDataWhenStatusError: requestOptions.receiveDataWhenStatusError,
              followRedirects: requestOptions.followRedirects,
              maxRedirects: requestOptions.maxRedirects,
              requestEncoder: requestOptions.requestEncoder,
              responseDecoder: requestOptions.responseDecoder,
              listFormat: requestOptions.listFormat
          );
          // 重新发送请求
          Response<dynamic> response = await dio.request(requestOptions.path,
              data: requestOptions.data,
              queryParameters: requestOptions.queryParameters,
              cancelToken: requestOptions.cancelToken,
              onSendProgress: requestOptions.onSendProgress,
              onReceiveProgress: requestOptions.onReceiveProgress,
              options: options
          );
          handler.resolve(response);
          return;
        }
      }
    }
    super.onError(err, handler);
  }
}