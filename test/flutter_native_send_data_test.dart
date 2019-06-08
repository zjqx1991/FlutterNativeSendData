import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_native_send_data/flutter_native_send_data.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_native_send_data');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterNativeSendData.platformVersion, '42');
  });
}
