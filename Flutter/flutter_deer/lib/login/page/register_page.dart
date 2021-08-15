import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/gaps.dart';
import 'package:flutter_deer/res/styles.dart';
import 'package:flutter_deer/util/change_notifier_mixin.dart';
import 'package:flutter_deer/widgets/fd_app_bar.dart';
import 'package:flutter_deer/widgets/fd_button.dart';
import 'package:flutter_deer/widgets/fd_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}): super(key: key);
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with ChangeNotifierMixin {

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _vcodeController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  final FocusNode _phoneNode = FocusNode();
  final FocusNode _vcodeNode = FocusNode();
  final FocusNode _pwdNode = FocusNode();
  bool _clickable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FDAppBar(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 0.0),
        child: Column(
          children: [
            Text(
              "Open your account",
              style: TextStyles.textBold26,
            ),
            Gaps.vGap16,
            FdTextField(
              controller: _phoneController,
              focusNode: _phoneNode,
              hintText: "Please enter phone number",
            ),
            Gaps.vGap8,
            FdTextField(
              controller: _vcodeController,
              focusNode: _vcodeNode,
              hintText: "Please enter verification code",
            ),
            Gaps.vGap8,
            FdTextField(
              controller: _pwdController,
              focusNode: _pwdNode,
              hintText: "Please enter the password",
              isPwd: true,
            ),
            Gaps.vGap8,
            FdButton(
              text: "Register",
              onPressed:  _clickable?() {}: null,
            )
          ],
        ),
      ),
    );
  }

  void verify() {
    String number = _phoneController.text;
    String vcode = _vcodeController.text;
    String pwd = _pwdController.text;

    bool clickable = true;
    if (number.isEmpty || number.length < 11 ||
        vcode.isEmpty || vcode.length < 6 ||
        pwd.isEmpty || pwd.length < 6) {
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
    List<VoidCallback> callbacks = [verify];
    return {
      _phoneController: callbacks,
      _vcodeController: callbacks,
      _pwdController: callbacks,
      _phoneNode: null,
      _vcodeNode: null,
      _pwdNode: null
    };
  }
}