import 'package:synchronized/synchronized.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MCSSpUtil {

  MCSSpUtil._();

  static MCSSpUtil? _singleton;
  static SharedPreferences? _sharedPreferences;
  static final Lock _lock = Lock();

  static Future<MCSSpUtil?> getInstance() async {
    if (_singleton == null) {
      await _lock.synchronized(() async {
        var singleton = MCSSpUtil._();
        singleton._init();
        _singleton = singleton;
      });
    }
    return _singleton;
  }

  void _init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool>? setBool(String key, bool value) {
    return _sharedPreferences?.setBool(key, value);
  }

  static bool getBool(String key, {bool defValue = false}) {
    return _sharedPreferences?.getBool(key) ?? defValue;
  }
}