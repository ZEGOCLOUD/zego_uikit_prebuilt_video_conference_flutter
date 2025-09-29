#import "ZegoUIKitPrebuiltVideoConferencePlugin.h"

@implementation ZegoUIKitPrebuiltVideoConferencePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"zego_uikit_prebuilt_video_conference"
            binaryMessenger:[registrar messenger]];
  ZegoUIKitPrebuiltVideoConferencePlugin* instance = [[ZegoUIKitPrebuiltVideoConferencePlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  result(FlutterMethodNotImplemented);
}

@end
