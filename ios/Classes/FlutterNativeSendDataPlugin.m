#import "FlutterNativeSendDataPlugin.h"

@implementation FlutterNativeSendDataPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {

  //创建通道
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_native_send_data"
            binaryMessenger:[registrar messenger]];

    
  FlutterNativeSendDataPlugin* instance = [[FlutterNativeSendDataPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}


/**
 监听通道的信息

 @param call 方法回调
 @param result 返回结构
 */
- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {

  //判断Flutter上层调用的方法
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  }
  else {
    result(FlutterMethodNotImplemented);
  }
}

@end
