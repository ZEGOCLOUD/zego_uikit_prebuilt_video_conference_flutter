// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:zego_uikit/zego_uikit.dart';

// Project imports:
import 'package:zego_uikit_prebuilt_video_conference/src/config.dart';
import 'package:zego_uikit_prebuilt_video_conference/src/events.dart';

part 'controller/private/private.dart';

part 'controller/room.dart';

part 'controller/private/room.dart';

part 'controller/screen.dart';

/// Used to control the video conference room functionality.
/// If the default video conference room UI and interactions do not meet your requirements, you can use this [ZegoUIKitPrebuiltVideoConferenceController] to actively control the business logic.
/// This class is used by setting the [controller] parameter in the constructor of [ZegoUIKitPrebuiltVideoConference].
class ZegoUIKitPrebuiltVideoConferenceController
    with
        ZegoVideoConferenceControllerPrivate,
        ZegoVideoConferenceControllerRoom,
        ZegoVideoConferenceControllerScreen {
  factory ZegoUIKitPrebuiltVideoConferenceController() => instance;

  String get version => "2.9.7";

  ZegoUIKitPrebuiltVideoConferenceController._internal() {
    ZegoLoggerService.logInfo(
      'ZegoUIKitPrebuiltVideoConferenceController create',
      tag: 'video-conference',
      subTag: 'controller',
    );
  }

  static final ZegoUIKitPrebuiltVideoConferenceController instance =
      ZegoUIKitPrebuiltVideoConferenceController._internal();

  /// This function is used to specify whether a certain user enters or exits full-screen mode during screen sharing.
  /// You need to provide the user's ID [userID] to determine which user to perform the operation on.
  /// By using a boolean value [isFullscreen], you can specify whether the user enters or exits full-screen mode.
  @Deprecated(
      'Since 2.5.0, please use [screen.showScreenSharingViewInFullscreenMode] instead')
  void showScreenSharingViewInFullscreenMode(String userID, bool isFullscreen) {
    screen.showScreenSharingViewInFullscreenMode(userID, isFullscreen);
  }
}
