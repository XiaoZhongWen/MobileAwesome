import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mcs_photo_picker/mcs_photo_picker.dart';

void main() {
  const MethodChannel channel = MethodChannel('mcs_photo_picker');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await McsPhotoPicker.platformVersion, '42');
  });
}
