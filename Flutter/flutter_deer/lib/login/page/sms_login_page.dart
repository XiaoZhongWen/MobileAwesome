import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/login/login_router.dart';
import 'package:flutter_deer/res/Dimens.dart';
import 'package:flutter_deer/res/gaps.dart';
import 'package:flutter_deer/res/styles.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/change_notifier_mixin.dart';
import 'package:flutter_deer/widgets/fd_app_bar.dart';
import 'package:flutter_deer/widgets/fd_button.dart';
import 'package:flutter_deer/widgets/fd_textfield.dart';

class SMSLoginPage extends StatefulWidget {

  const SMSLoginPage({Key? key}):super(key: key);

  _SMSLoginPageState createState() => _SMSLoginPageState();
}

class _SMSLoginPageState extends State<SMSLoginPage> with ChangeNotifierMixin {

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _vcodeController = TextEditingController();

  bool _clickable = false;

  final FocusNode _phoneNode = FocusNode();
  final FocusNode _vcodeNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FDAppBar(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 0.0),
        child: Column(
          children: [
            Text(
              "Verification Code Login",
              style: TextStyles.textBold26
            ),
            Gaps.vGap16,
            FdTextField(
              controller: _phoneController,
              keyboardType: TextInputType.number,
              hintText: "Please enter phone number",
              focusNode: _phoneNode,
            ),
            Gaps.vGap8,
            FdTextField(
              controller: _vcodeController,
              keyboardType: TextInputType.number,
              hintText: "please enter verification code",
              focusNode: _vcodeNode,
            ),
            Gaps.vGap8,
            Container(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                child: RichText(
                  text: TextSpan(
                      text: "Unregistered mobile phone number, please ",
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: Dimens.font_sp14),
                      children: [
                        TextSpan(
                            text: "Register",
                            style: TextStyle(color: Theme.of(context).errorColor)
                        ),
                        TextSpan(text: ".")
                      ]
                  ),
                ),
                onTap: () {
                  NavigatorUtils.push(context, LoginRouter.registerPage);
                },
              ),
            ),
            Gaps.vGap24,
            FdButton(
              text: "Login",
              onPressed: _clickable? () {}: null,
            ),
            Container(
              height: 40,
              alignment: Alignment.centerRight,
              child: GestureDetector(
                child: Text(
                    "Forgot Password",
                    style: TextStyles.textGray12
                ),
                onTap: () {
                  NavigatorUtils.push(context, LoginRouter.resetPasswordPage);
                },
              )
            )
          ],
        ),
      ),
    );
  }

  void _verify() {
    final phoneNumber = _phoneController.text;
    final vcode = _vcodeController.text;
    bool clickable = true;
    if (phoneNumber.isEmpty || phoneNumber.length < 11) {
      clickable = false;
    }

    if (vcode.isEmpty || vcode.length < 6) {
      clickable = false;
    }

    if (clickable != _clickable) {
      setState(() {
        _clickable = clickable;
      });
    }
  }

  @override
  Map<ChangeNotifier, List<VoidCallback>?>? changeNotifier() {
    List<VoidCallback> callbacks = [_verify];
    return {
      _phoneController: callbacks,
      _vcodeController: callbacks,
      _phoneNode: null,
      _vcodeNode: null
    };
  }
}