import 'package:fluro/fluro.dart';
import 'package:fluro/src/fluro_router.dart';
import 'package:flutter_deer/routers/i_router.dart';
import 'package:flutter_deer/shop/page/store_audio_result_page.dart';
import 'package:flutter_deer/store/page/store_audit_page.dart';

class StoreRouter implements IRouterProvider {

  static String store = "/store";
  static String auditPage = "/store/audit";
  static String auditResultPage = '/store/auditResult';

  @override
  void initRouter(FluroRouter router) {

    router.define(auditPage, handler: Handler(handlerFunc: (_,__) => const StoreAuditPage()));
    router.define(auditResultPage, handler: Handler(handlerFunc: (_,__) => const StoreAudioStorePage()));
  }
}