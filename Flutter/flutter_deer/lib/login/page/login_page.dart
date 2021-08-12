import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/login/login_router.dart';
import 'package:flutter_deer/res/constants.dart';
import 'package:flutter_deer/res/gaps.dart';
import 'package:flutter_deer/res/styles.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/store/store_router.dart';
import 'package:flutter_deer/util/change_notifier_mixin.dart';
import 'package:flutter_deer/widgets/fd_app_bar.dart';
import 'package:flutter_deer/widgets/fd_button.dart';
import 'package:flutter_deer/widgets/fd_textfield.dart';
import 'package:shared_preferences_extension/shared_preferences_extension.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({Key? key}): super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ChangeNotifierMixin {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _nameNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();

  bool _clickable = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      // print("addPostFrameCallback");
    });
    _nameController.text = SpExtension.getString(Constant.phone) ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FDAppBar(
        isBack: false,
        actionName: "Verification Code Login",
        onPressed: () {
          NavigatorUtils.push(context, LoginRouter.smsLoginPage);
        },
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Password Login",
              style: TextStyles.textBold26,
              textAlign: TextAlign.left,
            ),

            Gaps.vGap16,
            FdTextField(
              key: const Key("phone"),
              controller: _nameController,
              focusNode: _nameNode,
              hintText: "Please input username",
              maxLength: 11,
              keyboardType: TextInputType.phone,
            ),
            Gaps.vGap8,
            FdTextField(
              key: const Key("password"),
              controller: _passwordController,
              focusNode: _passwordNode,
              hintText: "Please enter the password",
              maxLength: 16,
              keyboardType: TextInputType.visiblePassword,
              isPwd: true,
            ),
            Gaps.vGap24,
            FdButton(
              key: const Key("login"),
              text: "Login",
              onPressed: _clickable? _login: null,
            ),
            Container(
              height: 40,
              alignment: Alignment.centerRight,
              child: GestureDetector(
                child: Text(
                  "Forgot Password",
                  key: const Key('forgotPassword'),
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                onTap: () {
                  NavigatorUtils.push(context, LoginRouter.resetPasswordPage);
                },
              ),
            ),
            Gaps.vGap16,
            Container(
              alignment: Alignment.center,
              child: GestureDetector(
                child: Text(
                  "No account yet? Register Now",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor
                  ),
                ),
                onTap: () {
                  NavigatorUtils.push(context, LoginRouter.registerPage);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _login() {
    SpExtension.putString(Constant.phone, _nameController.text);
    NavigatorUtils.push(context, StoreRouter.auditPage);
  }

  void _verify() {
    String name = _nameController.text;
    String pwd = _passwordController.text;

    bool clickable = true;
    if (name.isEmpty || name.length < 11) {
      clickable = false;
    }

    if (pwd.isEmpty || pwd.length < 6) {
      clickable = false;
    }

    if (_clickable != clickable) {
      setState(() {
        _clickable = clickable;
      });
    }
  }

  @override
  Map<ChangeNotifier, List<VoidCallback>?>? changeNotifier() {
    List<VoidCallback> callbacks = [_verify];
    return {
      _nameController: callbacks,
      _passwordController: callbacks,
      _nameNode: null,
      _passwordNode: null
    };
  }
}