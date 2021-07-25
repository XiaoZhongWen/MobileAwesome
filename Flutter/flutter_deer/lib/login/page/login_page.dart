import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/gaps.dart';
import 'package:flutter_deer/res/styles.dart';
import 'package:flutter_deer/util/change_notifier_mixin.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/widgets/fd_app_bar.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class LoginPage extends StatefulWidget  {

  const LoginPage({Key? key}):super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ChangeNotifierMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _nameNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();
  bool _clickable = false;

  @override
  Map<ChangeNotifier, List<VoidCallback>?>? changeNotifier() {
    final List<VoidCallback> callbacks = [_verify];
    return <ChangeNotifier, List<VoidCallback>?>{
      _nameController: callbacks,
      _passwordController: callbacks,
      _nameNode: null,
      _passwordNode: null
    };
  }

  @override
  Widget build(BuildContext context) {
    List<FocusNode> list = [_nameNode, _passwordNode];
    return Scaffold(
      appBar: FDAppBar(
        isBack: false,
        actionName: "Verification Code Login",
        onPressed: () {

        },
      ),
      body: KeyboardActions(
        config: KeyboardActionsConfig(
          keyboardBarColor: ThemeUtils.getKeyboardActionsColor(context),
          nextFocus: true,
          actions: List.generate(list.length, (index) => KeyboardActionsItem(
            focusNode: list[index],
            toolbarButtons: [
              (node) {
                return GestureDetector(
                  onTap: () => node.unfocus(),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Text("关闭"),
                  ),
                );
              }
            ]
          ))
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildBody,
          ),
        )
      )
    );
  }

  void _verify() {
    final String name = _nameController.text;
    final String password = _passwordController.text;
    bool clickable = true;
    if (name.isEmpty || name.length < 11) {
      clickable = false;
    }
    if (password.isEmpty || password.length < 6) {
      clickable = false;
    }
    if (clickable != _clickable) {
      setState(() {
        _clickable = clickable;
      });
    }
  }

  List<Widget> get _buildBody => <Widget>[
    Text("Password Login", style: TextStyles.textBold26),
    Gaps.vGap16,
    TextField(
      key: const Key("phone"),
      focusNode: _nameNode,
      controller: _nameController,
      maxLength: 11,
      keyboardType: TextInputType.phone,
    ),
    Gaps.vGap8,
    TextField(
      key: const Key("password"),
      focusNode: _passwordNode,
      controller: _passwordController,
      maxLength: 16,
      keyboardType: TextInputType.visiblePassword,
    ),
    Gaps.vGap24,
    TextButton(
        key: const Key("login"),
        onPressed: (){},
        child: Text("Login"),
    ),
    Container(
      height: 40.0,
      alignment: Alignment.centerRight,
      child: GestureDetector(
        child: Text(
          "Forget Password",
          key: Key("forgotPassword"),
          style: Theme.of(context).textTheme.subtitle2,
        ),
        onTap: () {},
      ),
    ),
    Gaps.vGap16,
    Container(
      alignment: Alignment.center,
      child: GestureDetector(
        child: Text(
          "No account yet? Register now",
          style: TextStyle(
            color: Theme.of(context).primaryColor
          ),
        ),
        onTap: () {},
      ),
    ),
  ];
}