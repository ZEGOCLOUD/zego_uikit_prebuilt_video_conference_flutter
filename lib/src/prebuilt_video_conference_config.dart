// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:zego_uikit/zego_uikit.dart';

// Project imports:
import 'package:zego_uikit_prebuilt_video_conference/src/prebuilt_video_conference_defines.dart';

class ZegoUIKitPrebuiltVideoConferenceConfig {
  ZegoUIKitPrebuiltVideoConferenceConfig({
    this.turnOnCameraWhenJoining = true,
    this.turnOnMicrophoneWhenJoining = true,
    this.useSpeakerWhenJoining = true,
    ZegoPrebuiltAudioVideoViewConfig? audioVideoViewConfig,
    ZegoTopMenuBarConfig? topMenuBarConfig,
    ZegoBottomMenuBarConfig? bottomMenuBarConfig,
    ZegoMemberListConfig? memberListConfig,
    this.leaveConfirmDialogInfo,
    this.onLeaveConfirmation,
    this.onLeave,
  })  : audioVideoViewConfig =
            audioVideoViewConfig ?? ZegoPrebuiltAudioVideoViewConfig(),
        topMenuBarConfig = topMenuBarConfig ??
            ZegoTopMenuBarConfig(style: ZegoMenuBarStyle.dark),
        bottomMenuBarConfig = bottomMenuBarConfig ?? ZegoBottomMenuBarConfig(),
        memberListConfig = memberListConfig ?? ZegoMemberListConfig() {
    layout ??= ZegoLayout.gallery();
  }

  /// whether to enable the camera by default, the default value is true
  bool turnOnCameraWhenJoining;

  /// whether to enable the microphone by default, the default value is true
  bool turnOnMicrophoneWhenJoining;

  /// whether to use the speaker by default, the default value is true;
  bool useSpeakerWhenJoining;

  /// configs about audio video view
  ZegoPrebuiltAudioVideoViewConfig audioVideoViewConfig;

  /// configs about top bar
  ZegoTopMenuBarConfig topMenuBarConfig;

  /// configs about bottom menu bar
  ZegoBottomMenuBarConfig bottomMenuBarConfig;

  /// configs about bottom member list
  ZegoMemberListConfig memberListConfig;

  /// layout config
  ZegoLayout? layout;

  /// alert dialog information of quit
  /// if confirm info is not null, APP will pop alert dialog when you hang up
  ZegoLeaveConfirmDialogInfo? leaveConfirmDialogInfo;

  /// It is often used to customize the process before exiting the call interface.
  /// The callback will triggered when user click hang up button or use system's return,
  /// If you need to handle custom logic, you can set this callback to handle (such as showAlertDialog to let user determine).
  /// if you return true in the callback, prebuilt page will quit and return to your previous page, otherwise will ignore.
  Future<bool?> Function(BuildContext context)? onLeaveConfirmation;

  /// customize handling after hang up
  VoidCallback? onLeave;
}

class ZegoPrebuiltAudioVideoViewConfig {
  /// hide microphone state of audio video view if set false
  bool showMicrophoneStateOnView;

  /// hide camera state of audio video view if set false
  bool showCameraStateOnView;

  /// hide user name of audio video view if set false
  bool showUserNameOnView;

  /// customize your foreground of audio video view, which is the top widget of stack
  /// <br><img src="https://doc.oa.zego.im/Pics/ZegoUIKit/Flutter/_default_avatar_nowave.jpg" width="5%">
  /// you can return any widget, then we will put it on top of audio video view
  AudioVideoViewForegroundBuilder? foregroundBuilder;

  /// customize your background of audio video view, which is the bottom widget of stack
  AudioVideoViewBackgroundBuilder? backgroundBuilder;

  /// video view mode
  /// if set to true, video view will proportional zoom fills the entire View and may be partially cut
  /// if set to false, video view proportional scaling up, there may be black borders
  bool useVideoViewAspectFill;

  /// hide avatar of audio video view if set false
  bool showAvatarInAudioMode;

  /// hide sound level of audio video view if set false
  bool showSoundWavesInAudioMode;

  /// customize your user's avatar, default we use userID's first character as avatar
  /// User avatars are generally stored in your server, ZegoUIkitPrebuiltVideoConference does not know each user's avatar, so by
  /// default, ZegoUIKitPrebuiltVideoConference will use the first letter of the user name to draw the default user avatar, as shown in the following figure,
  ///
  /// |When the user is not speaking|When the user is speaking|
  /// |--|--|
  /// |<img src="https://doc.oa.zego.im/Pics/ZegoUIKit/Flutter/_default_avatar_nowave.jpg" width="10%">|<img src="https://doc.oa.zego.im/Pics/ZegoUIKit/Flutter/_default_avatar.jpg" width="10%">|
  ///
  /// If you need to display the real avatar of your user, you can use the avatarBuilder to set the user avatar builder method (set user avatar widget builder), the usage is as follows:
  ///
  /// ```dart
  ///
  ///  // eg:
  ///  avatarBuilder: (BuildContext context, Size size, ZegoUIKitUser? user, Map extraInfo) {
  ///    return user != null
  ///        ? Container(
  ///            decoration: BoxDecoration(
  ///              shape: BoxShape.circle,
  ///              image: DecorationImage(
  ///                image: NetworkImage(
  ///                  'https://your_server/app/avatar/${user.id}.png',
  ///                ),
  ///              ),
  ///            ),
  ///          )
  ///        : const SizedBox();
  ///  },
  ///
  /// ```
  ///
  AudioVideoViewAvatarBuilder? avatarBuilder;

  ZegoPrebuiltAudioVideoViewConfig({
    this.showMicrophoneStateOnView = true,
    this.showCameraStateOnView = false,
    this.showUserNameOnView = true,
    this.foregroundBuilder,
    this.backgroundBuilder,
    this.useVideoViewAspectFill = false,
    this.showAvatarInAudioMode = true,
    this.showSoundWavesInAudioMode = true,
    this.avatarBuilder,
  });
}

class ZegoTopMenuBarConfig {
  ///
  bool isVisible;

  ///
  String title;

  /// if true, top bars will collapse after stand still for 5 seconds
  bool hideAutomatically;

  /// if true, top bars will collapse when clicks on blank spaces
  bool hideByClick;

  /// these buttons will displayed on the menu bar, order by the list
  List<ZegoMenuBarButtonName> buttons;

  /// style
  ZegoMenuBarStyle style;

  /// these buttons will sequentially added to menu bar,
  /// and auto added extra buttons to the pop-up menu
  /// when the limit [maxCount] is exceeded
  List<Widget> extendButtons;

  ZegoTopMenuBarConfig({
    this.isVisible = true,
    this.hideAutomatically = true,
    this.hideByClick = true,
    this.buttons = const [
      ZegoMenuBarButtonName.showMemberListButton,
      ZegoMenuBarButtonName.switchCameraButton,
    ],
    this.style = ZegoMenuBarStyle.dark,
    this.extendButtons = const [],
    this.title = "Meeting",
  });
}

class ZegoBottomMenuBarConfig {
  /// if true, menu bars will collapse after stand still for 5 seconds
  bool hideAutomatically;

  /// if true, menu bars will collapse when clicks on blank spaces
  bool hideByClick;

  /// these buttons will displayed on the menu bar, order by the list
  List<ZegoMenuBarButtonName> buttons;

  /// limited item count display on menu bar,
  /// if this count is exceeded, More button is displayed
  int maxCount;

  /// style
  ZegoMenuBarStyle style;

  /// these buttons will sequentially added to menu bar,
  /// and auto added extra buttons to the pop-up menu
  /// when the limit [maxCount] is exceeded
  List<Widget> extendButtons;

  ZegoBottomMenuBarConfig({
    this.hideAutomatically = true,
    this.hideByClick = true,
    this.buttons = const [
      ZegoMenuBarButtonName.toggleCameraButton,
      ZegoMenuBarButtonName.toggleMicrophoneButton,
      ZegoMenuBarButtonName.switchAudioOutputButton,
      ZegoMenuBarButtonName.leaveButton,
    ],
    this.maxCount = 5,
    this.style = ZegoMenuBarStyle.dark,
    this.extendButtons = const [],
  });
}

enum ZegoMenuBarStyle {
  light, // background is transparent
  dark, // background is black
}

class ZegoMemberListConfig {
  /// show microphone state or not
  bool showMicroPhoneState;

  /// show camera state or not
  bool showCameraState;

  /// customize your item view of member list
  MemberListItemBuilder? itemBuilder;

  ZegoMemberListConfig({
    this.showMicroPhoneState = true,
    this.showCameraState = true,
    this.itemBuilder,
  });
}

class ZegoLeaveConfirmDialogInfo {
  String title;
  String message;
  String cancelButtonName;
  String confirmButtonName;

  ZegoLeaveConfirmDialogInfo({
    this.title = "Leave the conference",
    this.message = "Are you sure to leave the conference?",
    this.cancelButtonName = "Cancel",
    this.confirmButtonName = "Confirm",
  });
}
