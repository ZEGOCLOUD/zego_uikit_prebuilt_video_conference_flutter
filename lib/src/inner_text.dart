// Project imports:
import 'package:zego_uikit_prebuilt_video_conference/src/defines.dart';

/// Control the text on the UI.
/// Modify the values of the corresponding properties to modify the text on the UI.
/// You can also change it to other languages.
/// This class is used for the ZegoUIKitPrebuiltVideoConferenceConfig.innerText property.
/// **Note that the placeholder %0 in the text will be replaced with the corresponding username.**
class ZegoUIKitPrebuiltLiveVideoConferenceInnerText {
  /// %0: is a string placeholder, represents the first parameter of prompt

  final String param_1 = '%0';

  ///When sharing the screen, the text prompt on the sharing side.
  String screenSharingTipText;

  ///When screen sharing, stop sharing button on the sharing side
  String stopScreenSharingButtonText;

  ZegoUIKitPrebuiltLiveVideoConferenceInnerText({
    String? screenSharingTipText,
    String? stopScreenSharingButtonText,
  })  : screenSharingTipText = 'You are sharing screen',
        stopScreenSharingButtonText = 'Stop sharing';
}
