import 'package:json_annotation/json_annotation.dart';

part 'mcs_login_page.g.dart';

@JsonSerializable()

class MCSLoginPage {

  MCSLoginPage(
      this.registerUrl,
      this.resetPwdUrl,
      this.changePwdUrl,
      this.loginUrl,
      this.showLastAvatar,
      this.showScanButton);

  String? registerUrl;
  String? resetPwdUrl;
  String? changePwdUrl;
  String? loginUrl;
  bool? showLastAvatar;
  bool? showScanButton;

  factory MCSLoginPage.fromJson(Map<String, dynamic> json) => _$MCSLoginPageFromJson(json);
  Map<String, dynamic> toJson() => _$MCSLoginPageToJson(this);
}