import 'package:flutter/material.dart';

class MCSLoginMessages extends ChangeNotifier {
  MCSLoginMessages({
    this.userHint = defaultUserHint,
    this.passwordHint = defaultPasswordHint,
    this.confirmPasswordHint = defaultConfirmPasswordHint,
    this.forgotPasswordButton = defaultForgotPasswordButton,
    this.loginButton = defaultLoginButton,
    this.signUpButton = defaultSignUpButton,
    this.signUpSuccess = defaultSignUpSuccess
  });

  static const String defaultUserHint = 'Username';
  static const String defaultPasswordHint = 'Password';
  static const String defaultConfirmPasswordHint = 'Confirm Password';
  static const String defaultForgotPasswordButton = 'Forgot Password?';
  static const String defaultLoginButton = 'LOGIN';
  static const String defaultSignUpButton = 'SIGNUP';
  static const String defaultSignUpSuccess = 'An activation link has been sent';

  final String userHint;
  final String passwordHint;
  final String confirmPasswordHint;
  final String forgotPasswordButton;
  final String loginButton;
  final String signUpButton;
  final String signUpSuccess;
}