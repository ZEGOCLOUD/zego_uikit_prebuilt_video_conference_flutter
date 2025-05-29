part of 'package:zego_uikit_prebuilt_video_conference/src/controller.dart';

mixin ZegoVideoConferenceControllerScreen {
  final _screenController = ZegoVideoConferenceScreenController();

  ZegoVideoConferenceScreenController get screen => _screenController;
}

/// Here are the APIs related to screen sharing.
class ZegoVideoConferenceScreenController
    with ZegoVideoConferenceScreenImplPrivate {
  ZegoScreenSharingViewController get screenSharingViewController =>
      private.viewController;

  /// This function is used to specify whether a certain user enters or exits full-screen mode during screen sharing.
  ///
  /// You need to provide the user's ID [userID] to determine which user to perform the operation on.
  /// By using a boolean value [isFullscreen], you can specify whether the user enters or exits full-screen mode.
  void showScreenSharingViewInFullscreenMode(String userID, bool isFullscreen) {
    ZegoLoggerService.logInfo(
      'showScreenSharingViewInFullscreenMode, '
      'userID:$userID, '
      'isFullscreen:$isFullscreen,',
      tag: 'video-conference',
      subTag: 'controller.room',
    );

    screenSharingViewController.showScreenSharingViewInFullscreenMode(
        userID, isFullscreen);
  }
}
