import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/db/mcs_db_service.dart';
import 'package:flutter_cloud_platform/base/providers/account_provider.dart';
import 'package:flutter_cloud_platform/base/utils/mcs_sp_util.dart';
import 'package:flutter_cloud_platform/base/providers/provider.dart';
import 'package:flutter_cloud_platform/contacts/providers/contacts_provider.dart';
import 'package:flutter_cloud_platform/login/login.dart';
import 'package:provider/provider.dart';
import 'routes/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MCSSpUtil.getInstance();
  runApp(Assassin());
}

class Assassin extends StatelessWidget {

  final VisualProvider _visualProvider = VisualProvider(null);

  Assassin({Key? key}):super(key: key) {
    // 初始化app路由
    RouterService.shared.initRoutes();
    // 打开数据库
    startDB();
  }

  void startDB() async {
    await MCSDBService.singleton.openDB();
    fetchAppVisual();
  }

  void fetchAppVisual() {
    _visualProvider.fetchPlatformVisual();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ThemeProvider()),
        ChangeNotifierProvider.value(value: LaunchProvider()),
        ChangeNotifierProvider.value(value: ConnectStatusProvider()),
        ChangeNotifierProvider.value(value: AccountProvider()),
        ChangeNotifierProvider.value(value: ContactsProvider()),
        ChangeNotifierProvider.value(value: _visualProvider)
      ],
      child: Consumer2<ThemeProvider, LaunchProvider>(
        builder: (_, themeProvider, launchProvider, __) {
          return MaterialApp(
            theme: themeProvider.getTheme(),
            home: launchProvider.launchPage()
          );
        },
      )
    );
  }
}

