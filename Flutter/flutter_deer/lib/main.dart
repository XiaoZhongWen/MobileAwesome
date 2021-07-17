import 'package:flutter/material.dart';
import 'package:flutter_deer/home/splash_page.dart';
import 'package:flutter_deer/routers/routers.dart';
import 'package:flutter_deer/setting/provider/locale_provider.dart';
import 'package:flutter_deer/setting/provider/theme_provider.dart';
import 'package:flutter_deer/util/handle_error_utils.dart';
import 'package:flutter_deer/util/log_utils.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences_extension/shared_preferences_extension.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /// 1. 初始化spExtension
  await SpExtension.getInstance();
  /// 2. 捕获flutter运行时异常
  handleError(runApp(MyApp()));
}

class MyApp extends StatelessWidget {

  final Widget? home;
  final ThemeData? theme;
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  MyApp({Key? key, this.home, this.theme}): super(key: key) {
    /// 1. 初始化Log
    Log.init();
    /// 2. 初始化Dio

    /// 3. 初始化路由
    Routers.initRouters();

    /// 4. 初始化QuickActions

  }

  @override
  Widget build(BuildContext context) {

    final Widget app = MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider())
      ],
      child: Consumer2<ThemeProvider, LocaleProvider>(
        builder: (_, ThemeProvider themeProvider, LocaleProvider localeProvider, __) {
          return _buildMaterialApp(themeProvider, localeProvider);
        },
      ),
    );

    return OKToast(
      child: app,
      backgroundColor: Colors.black54,
      textPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      radius: 20.0,
      position: ToastPosition.bottom,
    );

    // TODO: implement build
    throw UnimplementedError();
  }

  Widget _buildMaterialApp(ThemeProvider themeProvider, LocaleProvider localeProvider) {
    /// TODO 2021-06-12
    return MaterialApp(
      title: 'Flutter Deer',
      theme: theme ?? themeProvider.getTheme(),
      home: home ?? const SplashPage(),
    );
  }
}


