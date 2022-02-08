import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

extension ExString on String {
  String md5String() {
    var content = const Utf8Encoder().convert(this);
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }
}