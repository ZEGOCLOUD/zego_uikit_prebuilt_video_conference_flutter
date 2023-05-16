// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:zego_uikit/zego_uikit.dart';

// Project imports:
import 'package:zego_uikit_prebuilt_video_conference/src/prebuilt_video_conference_defines.dart';

/// Configuration for initializing the Video Conference
/// This class is used as the [config] parameter for the constructor of [ZegoUIKitPrebuiltVideoConference].
class ZegoUIKitPrebuiltVideoConferenceConfig {
  ZegoUIKitPrebuiltVideoConferenceConfig({
    this.turnOnCameraWhenJoining = true,
    this.turnOnMicrophoneWhenJoining = true,
    this.useSpeakerWhenJoining = true,
    ZegoPrebuiltAudioVideoViewConfig? audioVideoViewConfig,
    ZegoTopMenuBarConfig? topMenuBarConfig,
    ZegoBottomMenuBarConfig? bottomMenuBarConfig,
    ZegoMemberListConfig? memberListConfig,
    ZegoInRoomNotificationViewConfig? notificationViewConfig,
    ZegoInRoomChatViewConfig? chatViewConfig,
    this.leaveConfirmDialogInfo,
    this.onLeaveConfirmation,
    this.onLeave,
    this.avatarBuilder,
  })  : audioVideoViewConfig =
            audioVideoViewConfig ?? ZegoPrebuiltAudioVideoViewConfig(),
        topMenuBarConfig = topMenuBarConfig ??
            ZegoTopMenuBarConfig(style: ZegoMenuBarStyle.dark),
        bottomMenuBarConfig = bottomMenuBarConfig ?? ZegoBottomMenuBarConfig(),
        memberListConfig = memberListConfig ?? ZegoMemberListConfig(),
        notificationViewConfig =
            notificationViewConfig ?? ZegoInRoomNotificationViewConfig(),
        chatViewConfig = chatViewConfig ?? ZegoInRoomChatViewConfig() {
    layout ??= ZegoLayout.gallery();
  }

  /// Whether to open the camera when joining the video conference.
  ///
  /// If you want to join the video conference with your camera closed, set this value to false;
  /// if you want to join the video conference with your camera open, set this value to true.
  /// The default value is `true`.
  bool turnOnCameraWhenJoining;

  /// Whether to open the microphone when joining the video conference.
  ///
  /// If you want to join the video conference with your microphone closed, set this value to false;
  /// if you want to join the video conference with your microphone open, set this value to true.
  /// The default value is `true`.
  bool turnOnMicrophoneWhenJoining;

  /// Whether to use the speaker to play audio when joining the video conference.
  /// The default value is `true`.
  /// If this value is set to `false`, the system's default playback device, such as the earpiece or Bluetooth headset, will be used for audio playback.
  bool useSpeakerWhenJoining;

  /// Configuration options for audio/video views.
  ZegoPrebuiltAudioVideoViewConfig audioVideoViewConfig;

  /// Configuration options for the top menu bar (toolbar).
  /// You can use these options to customize the appearance and behavior of the top menu bar.
  ZegoTopMenuBarConfig topMenuBarConfig;

  /// Configuration options for the bottom menu bar (toolbar).
  /// You can use these options to customize the appearance and behavior of the bottom menu bar.
  ZegoBottomMenuBarConfig bottomMenuBarConfig;

  /// Configuration related to the bottom member list, including displaying the member list, member list styles, and more.
  ZegoMemberListConfig memberListConfig;

  /// Configuration related to the notification message list.
  ZegoInRoomNotificationViewConfig notificationViewConfig;

  /// Configuration related to the bottom-left message list.
  ZegoInRoomChatViewConfig chatViewConfig;

  /// Layout-related configuration. You can choose your layout here.
  ZegoLayout? layout;

  /// Use this to customize the avatar, and replace the default avatar with it.
  ///
  /// Example：
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
  ZegoAvatarBuilder? avatarBuilder;

  /// Confirmation dialog information when leaving the video conference.
  /// If not set, clicking the exit button will directly exit the video conference.
  /// If set, a confirmation dialog will be displayed when clicking the exit button, and you will need to confirm the exit before actually exiting.
  ZegoLeaveConfirmDialogInfo? leaveConfirmDialogInfo;

  /// Confirmation callback method before leaving the video conference.
  ///
  /// If you want to perform more complex business logic before exiting the video conference, such as updating some records to the backend, you can use the [onLeaveConfirmation] parameter to set it.
  /// This parameter requires you to provide a callback method that returns an asynchronous result.
  /// If you return true in the callback, the prebuilt page will quit and return to your previous page, otherwise it will be ignored.
  Future<bool?> Function(BuildContext context)? onLeaveConfirmation;

  /// This callback is triggered after leaving the vide conference.
  /// You can perform business-related prompts or other actions in this callback.
  VoidCallback? onLeave;
}

/// Configuration options for audio/video views.
/// These options allow you to customize the display effects of the audio/video views, such as showing microphone status and usernames.
/// If you need to customize the foreground or background of the audio/video view, you can use foregroundBuilder and backgroundBuilder.
/// If you want to hide user avatars or sound waveforms in audio mode, you can set showAvatarInAudioMode and showSoundWavesInAudioMode to false.
class ZegoPrebuiltAudioVideoViewConfig {
  /// Whether to mirror the displayed video captured by the camera.
  /// This mirroring effect only applies to the front-facing camera.
  /// Set it to true to enable mirroring, which flips the image horizontally.
  bool isVideoMirror;

  /// Whether to display the microphone status on the audio/video view.
  /// Set it to false if you don't want to show the microphone status on the audio/video view.
  bool showMicrophoneStateOnView;

  /// Whether to display the camera status on the audio/video view.
  /// Set it to false if you don't want to show the camera status on the audio/video view.
  bool showCameraStateOnView;

  /// Whether to display the username on the audio/video view.
  /// Set it to false if you don't want to show the username on the audio/video view.
  bool showUserNameOnView;

  /// You can customize the foreground of the audio/video view, which refers to the widget positioned on top of the view.
  /// You can return any widget, and we will place it at the top of the audio/video view.
  ZegoAudioVideoViewForegroundBuilder? foregroundBuilder;

  /// Background for the audio/video windows in a Video Conference.
  /// You can use any widget as the background for the audio/video windows. This can be a video, a GIF animation, an image, a web page, or any other widget.
  /// If you need to dynamically change the background content, you should implement the logic for dynamic modification within the widget you return.
  ZegoAudioVideoViewBackgroundBuilder? backgroundBuilder;

  /// Video view mode.
  /// Set it to true if you want the video view to scale proportionally to fill the entire view, potentially resulting in partial cropping.
  /// Set it to false if you want the video view to scale proportionally, potentially resulting in black borders.
  bool useVideoViewAspectFill;

  /// Whether to display user avatars in audio mode.
  /// Set it to false if you don't want to show user avatars in audio mode.
  bool showAvatarInAudioMode;

  /// Whether to display sound waveforms in audio mode.
  /// Set it to false if you don't want to show sound waveforms in audio mode.
  bool showSoundWavesInAudioMode;

  ZegoPrebuiltAudioVideoViewConfig({
    this.isVideoMirror = true,
    this.showMicrophoneStateOnView = true,
    this.showCameraStateOnView = false,
    this.showUserNameOnView = true,
    this.foregroundBuilder,
    this.backgroundBuilder,
    this.useVideoViewAspectFill = false,
    this.showAvatarInAudioMode = true,
    this.showSoundWavesInAudioMode = true,
  });
}

/// This enum consists of two style options: light and dark. T
/// he light style represents a light theme with a transparent background,
/// while the dark style represents a dark theme with a black background.
/// You can use these options to set the desired theme style for the menu bar.
enum ZegoMenuBarStyle {
  /// Light theme with transparent background
  light,

  /// Dark theme with black background
  dark,
}

/// Configuration options for the top menu bar (toolbar).
/// You can use the [ZegoUIKitPrebuiltVideoConferenceConfig].[topMenuBarConfig] property to set the properties inside this class.
class ZegoTopMenuBarConfig {
  /// Whether to display the top menu bar.
  bool isVisible;

  /// Title of the top menu bar.
  String title;

  /// Whether to automatically collapse the top menu bar after 5 seconds of inactivity.
  bool hideAutomatically;

  /// Whether to collapse the top menu bar when clicking on the blank area.
  bool hideByClick;

  /// Buttons displayed on the menu bar. The buttons will be arranged in the order specified in the list.
  List<ZegoMenuBarButtonName> buttons;

  /// Style of the top menu bar.
  ZegoMenuBarStyle style;

  /// Extension buttons that allow you to add your own buttons to the top toolbar.
  /// These buttons will be added to the menu bar in the specified order.
  /// If the limit of [3] is exceeded, additional buttons will be automatically added to the overflow menu.
  List<Widget> extendButtons;

  ZegoTopMenuBarConfig({
    this.isVisible = true,
    this.hideAutomatically = true,
    this.hideByClick = true,
    this.buttons = const [
      ZegoMenuBarButtonName.showMemberListButton,
      ZegoMenuBarButtonName.switchCameraButton,
      ZegoMenuBarButtonName.toggleScreenSharingButton,
    ],
    this.style = ZegoMenuBarStyle.dark,
    this.extendButtons = const [],
    this.title = 'Conference',
  });
}

/// Configuration options for the bottom menu bar (toolbar).
/// You can use the [ZegoUIKitPrebuiltVideoConferenceConfig].[bottomMenuBarConfig] property to set the properties inside this class.
class ZegoBottomMenuBarConfig {
  /// if true, menu bars will collapse after stand still for 5 seconds
  bool hideAutomatically;

  /// if true, menu bars will collapse when clicks on blank spaces
  bool hideByClick;

  /// these buttons will displayed on the menu bar, order by the list
  List<ZegoMenuBarButtonName> buttons;

  /// Controls the maximum number of buttons to be displayed in the menu bar (toolbar).
  /// When the number of buttons exceeds the `maxCount` limit, a "More" button will appear.
  /// Clicking on it will display a panel showing other buttons that cannot be displayed in the menu bar (toolbar).
  int maxCount;

  /// Button style for the bottom menu bar.
  ZegoMenuBarStyle style;

  /// Extension buttons that allow you to add your own buttons to the top toolbar.
  /// These buttons will be added to the menu bar in the specified order.
  /// If the limit of [maxCount] is exceeded, additional buttons will be automatically added to the overflow menu.
  List<Widget> extendButtons;

  ZegoBottomMenuBarConfig({
    this.hideAutomatically = true,
    this.hideByClick = true,
    this.buttons = const [
      ZegoMenuBarButtonName.toggleCameraButton,
      ZegoMenuBarButtonName.toggleMicrophoneButton,
      ZegoMenuBarButtonName.leaveButton,
      ZegoMenuBarButtonName.switchAudioOutputButton,
      ZegoMenuBarButtonName.chatButton,
    ],
    this.maxCount = 5,
    this.style = ZegoMenuBarStyle.dark,
    this.extendButtons = const [],
  });
}

/// Configuration for the member list.
/// You can use the [ZegoUIKitPrebuiltVideoConferenceConfig].[memberListConfig] property to set the properties inside this class.
///
/// If you want to use a custom member list item view, you can set the `itemBuilder` property in `ZegoMemberListConfig`
/// and pass your custom view's builder function to it.
/// For example, suppose you have implemented a `CustomMemberListItem` component that can render a member list item view based on the user information. You can set it up like this:
///
/// ZegoMemberListConfig(
///   showMicrophoneState: true,
///   showCameraState: false,
///   itemBuilder: (BuildContext context, Size size, ZegoUIKitUser user, Map<String, dynamic> extraInfo) {
///     return CustomMemberListItem(user: user);
///   },
/// );
///
/// In this example, we set `showMicrophoneState` to true, so the microphone state will be displayed in the member list item.
/// `showCameraState` is set to false, so the camera state will not be displayed.
/// Finally, we pass the builder function of the custom view, `CustomMemberListItem`, to the `itemBuilder` property so that the member list item will be rendered using the custom component.
class ZegoMemberListConfig {
  /// Whether to show the microphone state of the member. Defaults to true, which means it will be shown.
  bool showMicrophoneState;

  /// Whether to show the camera state of the member. Defaults to true, which means it will be shown.
  bool showCameraState;

  /// Custom member list item view.
  ZegoMemberListItemBuilder? itemBuilder;

  ZegoMemberListConfig({
    this.showMicrophoneState = true,
    this.showCameraState = true,
    this.itemBuilder,
  });
}

///  the configuration for the leave confirmation dialog
/// You can use the [ZegoUIKitPrebuiltVideoConferenceConfig].[leaveConfirmDialogInfo] property to set the properties inside this class.
class ZegoLeaveConfirmDialogInfo {
  /// The title of the dialog
  String title;

  /// The message content of the dialog
  String message;

  /// The text for the cancel button
  String cancelButtonName;

  /// The text for the confirm button
  String confirmButtonName;

  ZegoLeaveConfirmDialogInfo({
    this.title = 'Leave the conference',
    this.message = 'Are you sure to leave the conference?',
    this.cancelButtonName = 'Cancel',
    this.confirmButtonName = 'OK',
  });
}

/// This class is used for the [notificationViewConfig] property of [ZegoUIKitPrebuiltVideoConferenceConfig].
///
/// you can control whether to receive notifications when a user leaves the room by setting the notifyUserLeave property.
/// You can also provide custom builders (itemBuilder, userJoinItemBuilder, userLeaveItemBuilder) to customize the appearance and content of the notification message, user join item, and user leave item.
/// These builders allow you to create your own custom widgets for displaying the notifications.
class ZegoInRoomNotificationViewConfig {
  /// Set this to true if you want to be notified when a user leaves the room.
  /// The default value is true.
  bool notifyUserLeave;

  /// The builder for customizing the notification message item.
  ZegoNotificationMessageItemBuilder? itemBuilder;

  /// The builder for customizing the user join item.
  ZegoNotificationUserItemBuilder? userJoinItemBuilder;

  /// The builder for customizing the user leave item.
  ZegoNotificationUserItemBuilder? userLeaveItemBuilder;

  ZegoInRoomNotificationViewConfig({
    this.notifyUserLeave = true,
    this.itemBuilder,
    this.userJoinItemBuilder,
    this.userLeaveItemBuilder,
  });
}

/// Control options for the bottom-left message list.
/// This class is used for the [chatViewConfig] property of [ZegoUIKitPrebuiltVideoConferenceConfig].
///
/// If you want to customize chat messages, you can specify the [itemBuilder] in [ZegoInRoomMessageViewConfig].
///
/// Example:
///
/// ZegoInRoomMessageViewConfig(
///   itemBuilder: (BuildContext context, ZegoRoomMessage message) {
///     return ListTile(
///       title: Text(message.message),
///       subtitle: Text(message.user.id),
///     );
///   },
/// );
class ZegoInRoomChatViewConfig {
  /// Use this to customize the style and content of each chat message list item.
  /// For example, you can modify the background color, opacity, border radius, or add additional information like the sender's level or role.
  ZegoInRoomMessageItemBuilder? itemBuilder;

  ZegoInRoomChatViewConfig({
    this.itemBuilder,
  });
}
