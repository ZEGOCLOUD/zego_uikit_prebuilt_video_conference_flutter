// Package imports:
import 'package:zego_uikit/zego_uikit.dart';

class ZegoUIKitPrebuiltVideoConferenceController {
  final screenSharingViewController = ZegoScreenSharingViewController();

  void showScreenSharingViewInFullscreenMode(String userID, bool isFullscreen) {
    screenSharingViewController.showScreenSharingViewInFullscreenMode(
        userID, isFullscreen);
  }
}
