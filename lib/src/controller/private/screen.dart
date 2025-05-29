part of 'package:zego_uikit_prebuilt_video_conference/src/controller.dart';

/// @nodoc
mixin ZegoVideoConferenceScreenImplPrivate {
  final _private = ZegoVideoConferenceScreenImplPrivateImpl();

  /// Don't call that
  ZegoVideoConferenceScreenImplPrivateImpl get private => _private;
}

/// @nodoc
class ZegoVideoConferenceScreenImplPrivateImpl {
  final viewController = ZegoScreenSharingViewController();

  /// Please do not call this interface. It is the internal logic of Prebuilt.
  Future<void> initByPrebuilt({
    required ZegoUIKitPrebuiltVideoConferenceConfig? config,
  }) async {
    ZegoLoggerService.logInfo(
      'init by prebuilt',
      tag: 'video-conference',
      subTag: 'controller.screenSharing.p',
    );

    viewController.private.sharingTipText =
        config?.innerText.screenSharingTipText;
    viewController.private.stopSharingButtonText =
        config?.innerText.stopScreenSharingButtonText;
  }

  /// Please do not call this interface. It is the internal logic of Prebuilt.
  void uninitByPrebuilt() {
    ZegoLoggerService.logInfo(
      'un-init by prebuilt',
      tag: 'video-conference',
      subTag: 'controller.pip.p',
    );
  }
}
