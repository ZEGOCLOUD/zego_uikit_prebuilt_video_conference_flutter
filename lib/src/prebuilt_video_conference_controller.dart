// Package imports:
import 'package:zego_uikit/zego_uikit.dart';

/// Used to control the video conference room functionality.
/// If the default video conference room UI and interactions do not meet your requirements, you can use this [ZegoUIKitPrebuiltVideoConferenceController] to actively control the business logic.
/// This class is used by setting the [controller] parameter in the constructor of [ZegoUIKitPrebuiltVideoConference].
class ZegoUIKitPrebuiltVideoConferenceController {
  final screenSharingViewController = ZegoScreenSharingViewController();

  /// This function is used to specify whether a certain user enters or exits full-screen mode during screen sharing.
  /// You need to provide the user's ID [userID] to determine which user to perform the operation on.
  /// By using a boolean value [isFullscreen], you can specify whether the user enters or exits full-screen mode.
  void showScreenSharingViewInFullscreenMode(String userID, bool isFullscreen) {
    screenSharingViewController.showScreenSharingViewInFullscreenMode(
        userID, isFullscreen);
  }
}
