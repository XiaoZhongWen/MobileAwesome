import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/dao/account_dao.dart';
import 'package:flutter_cloud_platform/base/network/auth_api.dart';
import 'package:flutter_cloud_platform/base/providers/account_provider.dart';
import 'package:flutter_cloud_platform/base/providers/provider.dart';
import 'package:flutter_cloud_platform/base/service/mcs_im_service.dart';
import 'package:flutter_cloud_platform/login/models/mcs_login_data.dart';
import 'package:flutter_cloud_platform/login/providers/mcs_auth.dart';
import 'package:flutter_cloud_platform/login/providers/mcs_login_messages.dart';
import 'package:flutter_cloud_platform/login/models/account.dart';
import 'package:provider/provider.dart';
import '../../base/widgets/mcs_widgets.dart';
import '../widgets/login_widgets.dart';
import '../../base/constant/mcs_constant.dart';
import '../../base/extension/extension.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
    this.loginMessages,
  }) : super(key: key);

  final MCSLoginMessages? loginMessages;

  static String? defaultValidator(String? value) {
    final s = value ?? "";
    if (s.isEmpty) {
      return "Invalid";
    }
    return null;
  }

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Widget _buildHeader(double height) {
    double top = MediaQuery.of(context).padding.top;
    return SafeArea(
        child: SizedBox(
          height: height - top,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: Consumer<AccountProvider>(
                  builder: (_, accountProvider, __) {
                    String headUrl = accountProvider.headUrl() ?? 'https://wx2.sinaimg.cn/mw2000/b4505429ly8gcwoi6xlvcj20e80e8glx.jpg';
                    return Image(
                      image: NetworkImage(headUrl),
                      width: MCSLayout.loginIconWidth,
                      height: MCSLayout.loginIconHeight,
                      fit: BoxFit.cover,
                    );
                  },
                )
              ),
            ],
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    final loginCardTopMargin = (deviceSize.height - MCSLayout.loginCardHeight) / 2;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: widget.loginMessages ?? MCSLoginMessages()),
        ChangeNotifierProvider.value(value: MCSAuth(onLogin: onLogin))
      ],
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            const MCSGradientBox(colors: [MCSColors.mainColor, MCSColors.darkMainColor]),
            SingleChildScrollView(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                        child: CardBuilder(
                          padding: EdgeInsets.only(top: loginCardTopMargin),
                          usernameValidator: usernameValidator,
                          passwordValidator: passwordValidator,
                        )
                    ),
                    Positioned(
                      top: 0,
                      child: _buildHeader(loginCardTopMargin),
                    )
                  ],
                )
            )
          ],
        ),
      )
    );
  }

  String? usernameValidator(String? value) {
    String username = value ?? '';
    if (username.isEmpty) {
      return 'username is empty';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    String password = value ?? '';
    if (password.length <= 6) {
      return 'password length less than 6';
    }
    return null;
  }

  Future<String?> onLogin(MCSLoginData data) async {
    String userId = data.username;
    String pwd = data.password.md5String();
    bool success = await MCSIMService.singleton.login(userId, pwd);
    Account? account = await AuthApi.singleton.login(userId, pwd);
    bool result = success && account != null;
    if (result) {
      LaunchProvider provider = Provider.of<LaunchProvider>(context, listen: false);
      provider.launchType = LaunchType.main;
    }
    return result? '登录成功': '用户名或密码错误';
  }
}
