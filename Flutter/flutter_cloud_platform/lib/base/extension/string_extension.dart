import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';

extension ExString on String {
  String md5String() {
    var content = const Utf8Encoder().convert(this);
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  bool isGroupId() {
    return startsWith(prefixGroupId);
  }

  bool isMassId() {
    return startsWith(prefixMassId);
  }

  bool isTextMeetingId() {
    return startsWith(prefixTextMeetingId);
  }

  bool isPublicAccountId() {
    return startsWith(prefixPublicAccountId);
  }

  bool isServiceAccountId() {
    return startsWith(prefixServiceAccountId);
  }

  bool isRobotAccountId() {
    return startsWith(prefixRobotAccountId);
  }

  bool isPublicAccountManager() {
    const String regex = '(_pa_)[\\d]+-[\\w]+';
    return RegExp(regex).firstMatch(this) != null;
  }
}