import 'dart:async';

import 'package:flutter/services.dart';
/*
* 从上层（Flutter层）到底层（Android || iOS）数据交换
*
* 这里的 数据交换指向（上层到底层），是指
* 1、由上层 主动发送数据到底层
* 2、由上层 主动向底层获取数据
*/

/*
* 插件的通道，用于连通 上层和底层 的通道
*
* */
class FlutterNativeSendData {
  ///创建一个通道，flutter_native_send_data 是通道的唯一标识
  static const MethodChannel _channel =
      const MethodChannel('flutter_native_send_data');


  ///交换数据的方法：getPlatformVersion
  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
