part of 'package:zego_uikit_prebuilt_video_conference/src/controller.dart';

/// @nodoc
mixin ZegoVideoConferenceControllerRoomPrivate {
  final _impl = ZegoVideoConferenceControlleRoomrPrivateImpl();

  /// Don't call that
  ZegoVideoConferenceControlleRoomrPrivateImpl get private => _impl;
}

/// @nodoc
class ZegoVideoConferenceControlleRoomrPrivateImpl {
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
