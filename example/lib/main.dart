import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_native_send_data/flutter_native_send_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
//    initPlatformState();
  }

  ///向通道发送获取平台系统版本号
  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await FlutterNativeSendData.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  ///向通道发送参数
  Future<void> sendParams() async{
    Map map = {
      "name":"Revan",
      "age" :29
    };
    FlutterNativeSendData.flutterToNativeParams(map);
  }

  void receiveData() async{
    Map mapdata;
    try {
      mapdata = await FlutterNativeSendData.flutterReceiveData();
    }
    on PlatformException {
      _platformVersion = "没有获取到底层的数据";
    }

    setState(() {
      _platformVersion = "${mapdata['platform']}: ${mapdata['systemVersion']}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter层向底层发送数据'),
        ),
        body: Center(
          child: Column (
            children: <Widget>[
              RaisedButton(
                child: Text('向底层发送参数'),
                  onPressed: sendParams,
              ),
              RaisedButton(
                  child: Text('接收底层返回参数'),
                  onPressed: receiveData
              ),
              Text('Running on: $_platformVersion\n'),
            ],
          )
        ),
      ),
    );
  }
}
