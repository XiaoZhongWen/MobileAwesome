import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/providers/account_provider.dart';
import 'package:flutter_cloud_platform/login/models/account.dart';
import 'package:flutter_cloud_platform/login/models/mcs_login_data.dart';
import 'package:flutter_cloud_platform/login/providers/mcs_auth.dart';
import 'package:flutter_cloud_platform/login/providers/mcs_login_messages.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../base/constant/mcs_constant.dart';
import '../../../base/widgets/mcs_widgets.dart';

class LoginCard extends StatefulWidget {
  const LoginCard({
    Key? key,
    @required this.usernameValidator,
    @required this.passwordValidator}) : super(key: key);

  final FormFieldValidator<String>? usernameValidator;
  final FormFieldValidator<String>? passwordValidator;

  @override
  _LoginCardState createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> with SingleTickerProviderStateMixin {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _passwordController;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _passwordController = TextEditingController();
    final accountProvider = Provider.of<AccountProvider>(context, listen:false);
    Account? account = accountProvider.currentAccount;
    _nameController.text = account?.userId ?? '';
  }

  Widget _buildUserField(MCSLoginMessages messages, MCSAuth auth) {
    return MCSAnimatedTextFormField(
      controller: _nameController,
      labelText: messages.userHint,
      prefixIcon: const Icon(FontAwesomeIcons.solidUserCircle),
      validator: widget.usernameValidator,
      onSaved: (username) => auth.username = username ?? '',
      enabled: !_isSubmitting,
    );
  }

  Widget _buildPasswordField(MCSLoginMessages messages, MCSAuth auth) {
    return MCSAnimatedTextFormField(
      controller: _passwordController,
      labelText: messages.passwordHint,
      prefixIcon: const Icon(FontAwesomeIcons.lock),
      validator: widget.passwordValidator,
      secure: true,
      onSaved: (password) => auth.password = password ?? '',
      enabled: !_isSubmitting,
    );
  }

  Widget _buildLoginButton(MCSLoginMessages messages, BuildContext context) {
    final theme = Theme.of(context);
    return _isSubmitting?
        CircularProgressIndicator(
          backgroundColor: MCSColors.fillColor,
          valueColor: const AlwaysStoppedAnimation(MCSColors.mainColor),
        ):
    Material(
      color: theme.floatingActionButtonTheme.backgroundColor,
      shadowColor: theme.floatingActionButtonTheme.backgroundColor,
      shape: theme.floatingActionButtonTheme.shape,
      elevation: theme.floatingActionButtonTheme.elevation ?? 0.0,
      child: InkWell(
          onTap: _submit,
          child: Container(
            width: 120,
            height: 40,
            alignment: Alignment.center,
            child: Text(messages.loginButton, style: theme.textTheme.button,),
          )
      ),
    );
  }

  Future<bool> _submit() async {
    setState(() {
      _isSubmitting = true;
    });
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final auth = Provider.of<MCSAuth>(context, listen: false);
      final errorMsg = await auth.onLogin?.call(MCSLoginData(
        username: auth.username,
        password: auth.password
      ));
      setState(() {
        _isSubmitting = false;
      });
      if (errorMsg == null) {
        return true;
      } else {
        return false;
      }
    } else {
      setState(() {
        _isSubmitting = false;
      });
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth = min(MediaQuery.of(context).size.width * 0.75, 360.0);
    final messages = Provider.of<MCSLoginMessages>(context, listen: false);
    final auth = Provider.of<MCSAuth>(context, listen: true);
    Form form = Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: MCSLayout.padding,
              right: MCSLayout.padding,
              top: MCSLayout.padding + MCSLayout.margin
            ),
            width: cardWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MCSLayout.topMargin,),
                _buildUserField(messages, auth),
                SizedBox(height: MCSLayout.topMargin,),
                _buildPasswordField(messages, auth),
                SizedBox(height: MCSLayout.topMargin,),
                Container(
                  alignment: Alignment.center,
                  child: _buildLoginButton(messages, context)
                ),
                SizedBox(height: MCSLayout.topMargin,),
              ],
            ),
          )
        ],
      ),
    );

    return FittedBox(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        child: form,
      ),
    );
  }
}
