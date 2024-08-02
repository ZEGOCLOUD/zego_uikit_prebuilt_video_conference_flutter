part of 'package:zego_uikit_prebuilt_video_conference/src/controller.dart';

/// @nodoc
mixin ZegoVideoConferenceControllerPrivate {
  final _private = ZegoVideoConferenceControllerPrivateImpl();

  /// Don't call that
  ZegoVideoConferenceControllerPrivateImpl get private => _private;
}

/// @nodoc
class ZegoVideoConferenceControllerPrivateImpl {
  ZegoUIKitPrebuiltVideoConferenceConfig? config;
  ZegoUIKitPrebuiltVideoConferenceEvents? events;

  /// DO NOT CALL
  /// Call Inside By Prebuilt
  /// prebuilt assign value to internal variables
  void initByPrebuilt({
    required ZegoUIKitPrebuiltVideoConferenceConfig config,
    required ZegoUIKitPrebuiltVideoConferenceEvents events,
  }) {
    ZegoLoggerService.logInfo(
      'init by prebuilt',
      tag: 'video-conference',
      subTag: 'controller.p',
    );

    this.config = config;
    this.events = events;
  }

  /// DO NOT CALL
  /// Call Inside By Prebuilt
  /// prebuilt assign value to internal variables
  void uninitByPrebuilt() {
    ZegoLoggerService.logInfo(
      'un-init by prebuilt',
      tag: 'video-conference',
      subTag: 'controller.p',
    );

    config = null;
    events = null;
  }
}
