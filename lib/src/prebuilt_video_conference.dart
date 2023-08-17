// Dart imports:
import 'dart:async';
import 'dart:core';
import 'dart:developer';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:permission_handler/permission_handler.dart';
import 'package:zego_uikit/zego_uikit.dart';

// Project imports:
import 'package:zego_uikit_prebuilt_video_conference/src/components/components.dart';
import 'package:zego_uikit_prebuilt_video_conference/src/components/pop_up_manager.dart';
import 'package:zego_uikit_prebuilt_video_conference/src/prebuilt_video_conference_config.dart';
import 'package:zego_uikit_prebuilt_video_conference/src/prebuilt_video_conference_controller.dart';

/// Video Conference Widget.
/// You can embed this widget into any page of your project to integrate the functionality of a video conference.
/// You can refer to our [documentation](https://docs.zegocloud.com/article/14902),
/// or our [sample code](https://github.com/ZEGOCLOUD/zego_uikit_prebuilt_video_conference_example_flutter).
class ZegoUIKitPrebuiltVideoConference extends StatefulWidget {
  const ZegoUIKitPrebuiltVideoConference({
    Key? key,
    required this.appID,
    required this.appSign,
    required this.conferenceID,
    required this.userID,
    required this.userName,
    required this.config,
    this.controller,
    @Deprecated('Since 2.2.1') this.appDesignSize,
  }) : super(key: key);

  /// You can create a project and obtain an appID from the [ZEGOCLOUD Admin Console](https://console.zegocloud.com).
  final int appID;

  /// You can create a project and obtain an appSign from the [ZEGOCLOUD Admin Console](https://console.zegocloud.com).
  final String appSign;

  /// The ID of the currently logged-in user.
  /// It can be any valid string.
  /// Typically, you would use the ID from your own user system, such as Firebase.
  final String userID;

  /// The name of the currently logged-in user.
  /// It can be any valid string.
  /// Typically, you would use the name from your own user system, such as Firebase.
  final String userName;

  /// You can customize the conferenceID arbitrarily,
  /// just need to know: users who use the same conferenceID can talk with each other.
  final String conferenceID;

  /// Initialize the configuration for the video conference.
  final ZegoUIKitPrebuiltVideoConferenceConfig config;

  /// You can invoke the methods provided by [ZegoUIKitPrebuiltVideoConference] through the [controller].
  final ZegoUIKitPrebuiltVideoConferenceController? controller;

  @Deprecated('Since 2.2.1')
  final Size? appDesignSize;

  /// @nodoc
  @override
  State<ZegoUIKitPrebuiltVideoConference> createState() =>
      _ZegoUIKitPrebuiltVideoConferenceState();
}

/// @nodoc
class _ZegoUIKitPrebuiltVideoConferenceState
    extends State<ZegoUIKitPrebuiltVideoConference>
    with SingleTickerProviderStateMixin {
  var barVisibilityNotifier = ValueNotifier<bool>(true);
  var barRestartHideTimerNotifier = ValueNotifier<int>(0);
  var chatViewVisibleNotifier = ValueNotifier<bool>(false);

  final popUpManager = ZegoPopUpManager();
  List<StreamSubscription<dynamic>?> subscriptions = [];

  bool get isLightStyle =>
      ZegoMenuBarStyle.light == widget.config.bottomMenuBarConfig.style;

  @override
  void initState() {
    super.initState();

    ZegoUIKit().getZegoUIKitVersion().then((version) {
      log('version: zego_uikit_prebuilt_video_conference:2.3.2; $version');
    });

    subscriptions.add(
        ZegoUIKit().getMeRemovedFromRoomStream().listen(onMeRemovedFromRoom));

    initContext();
  }

  @override
  void dispose() {
    super.dispose();

    ZegoUIKit().leaveRoom();
  }

  @override
  Widget build(BuildContext context) {
    widget.config.onLeaveConfirmation ??= onLeaveConfirmation;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
        onWillPop: () async {
          return await widget.config.onLeaveConfirmation!(context) ?? false;
        },
        child: ZegoScreenUtilInit(
          designSize: const Size(750, 1334),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return clickListener(
                  child: Stack(
                    children: [
                      audioVideoContainer(
                        constraints.maxWidth,
                        constraints.maxHeight,
                      ),
                      if (widget.config.topMenuBarConfig.isVisible)
                        topMenuBar()
                      else
                        Container(),
                      notificationView(),
                      bottomMenuBar(),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> initPermissions() async {
    if (widget.config.turnOnCameraWhenJoining) {
      await requestPermission(Permission.camera);
    }
    if (widget.config.turnOnMicrophoneWhenJoining) {
      await requestPermission(Permission.microphone);
    }
  }

  void initContext() {
    correctConfigValue();

    assert(widget.userID.isNotEmpty);
    assert(widget.userName.isNotEmpty);
    assert(widget.appID > 0);
    assert(widget.appSign.isNotEmpty);

    final config = widget.config;
    initPermissions().then((value) {
      ZegoUIKit().login(widget.userID, widget.userName);
      ZegoUIKit()
          .init(appID: widget.appID, appSign: widget.appSign)
          .then((value) {
        ZegoUIKit()
          ..useFrontFacingCamera(true)
          ..updateVideoViewMode(
              config.audioVideoViewConfig.useVideoViewAspectFill)
          ..enableVideoMirroring(config.audioVideoViewConfig.isVideoMirror)
          ..turnCameraOn(config.turnOnCameraWhenJoining)
          ..turnMicrophoneOn(config.turnOnMicrophoneWhenJoining)
          ..setAudioOutputToSpeaker(config.useSpeakerWhenJoining);

        ZegoUIKit().joinRoom(widget.conferenceID).then((result) async {
          assert(result.errorCode == 0);

          if (result.errorCode != 0) {
            ZegoLoggerService.logError(
              'failed to login room:${result.errorCode},${result.extendedData}',
              tag: 'video conference',
              subTag: 'prebuilt',
            );
          }
        });
      });
    });
  }

  void correctConfigValue() {
    if (widget.config.bottomMenuBarConfig.maxCount > 5) {
      widget.config.bottomMenuBarConfig.maxCount = 5;
      ZegoLoggerService.logInfo(
        "menu bar buttons limited count's value  is exceeding the maximum limit",
        tag: 'video conference',
        subTag: 'prebuilt',
      );
    }
  }

  Widget clickListener({required Widget child}) {
    return GestureDetector(
      onTap: () {
        /// listen only click event in empty space
        if (widget.config.bottomMenuBarConfig.hideByClick) {
          barVisibilityNotifier.value = !barVisibilityNotifier.value;
        }
      },
      child: Listener(
        ///  listen for all click events in current view, include the click
        ///  receivers(such as button...), but only listen
        onPointerDown: (e) {
          barRestartHideTimerNotifier.value =
              DateTime.now().millisecondsSinceEpoch;
        },
        child: AbsorbPointer(
          absorbing: false,
          child: child,
        ),
      ),
    );
  }

  Widget audioVideoContainer(double width, double height) {
    return Positioned(
      top: 0,
      left: 0,
      child: SizedBox(
        width: width,
        height: height,
        child: ZegoAudioVideoContainer(
          layout: widget.config.layout!,
          backgroundBuilder: audioVideoViewBackground,
          foregroundBuilder: audioVideoViewForeground,
          screenSharingViewController:
              widget.controller?.screenSharingViewController,
          avatarConfig: ZegoAvatarConfig(
            showInAudioMode:
                widget.config.audioVideoViewConfig.showAvatarInAudioMode,
            showSoundWavesInAudioMode:
                widget.config.audioVideoViewConfig.showSoundWavesInAudioMode,
            builder: widget.config.avatarBuilder,
          ),
        ),
      ),
    );
  }

  Widget notificationView() {
    return ValueListenableBuilder<bool>(
      valueListenable: barVisibilityNotifier,
      builder: (context, isBarVisible, _) {
        return Positioned(
          // left: 32.r,
          bottom: isBarVisible ? 232.zR : 24.zR,
          child: ConstrainedBox(
            constraints: BoxConstraints.loose(Size(540.zR, 400.zR)),
            child: ZegoInRoomNotificationView(
              notifyUserLeave:
                  widget.config.notificationViewConfig.notifyUserLeave,
              itemBuilder: widget.config.notificationViewConfig.itemBuilder ??
                  notificationMessageItemBuilder,
              userJoinItemBuilder:
                  widget.config.notificationViewConfig.userJoinItemBuilder ??
                      notificationUserJoinItemBuilder,
              userLeaveItemBuilder:
                  widget.config.notificationViewConfig.userLeaveItemBuilder ??
                      notificationUserLeaveItemBuilder,
            ),
          ),
        );
      },
    );
  }

  Widget notificationMessageItemBuilder(
    BuildContext context,
    ZegoInRoomMessage message,
    Map<String, dynamic> extraInfo,
  ) {
    return ZegoInRoomNotificationViewItem(
      maxLines: 3,
      user: message.user,
      message: message.message,
      isHorizontal: false,
    );
  }

  Widget notificationUserJoinItemBuilder(
    BuildContext context,
    ZegoUIKitUser user,
    Map<String, dynamic> extraInfo,
  ) {
    return ZegoInRoomNotificationViewItem(
      user: user,
      message: 'joins the conference.',
      isHorizontal: false,
    );
  }

  Widget notificationUserLeaveItemBuilder(
    BuildContext context,
    ZegoUIKitUser user,
    Map<String, dynamic> extraInfo,
  ) {
    return ZegoInRoomNotificationViewItem(
      user: user,
      message: 'left the conference.',
      isHorizontal: false,
    );
  }

  Widget topMenuBar() {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      child: ZegoTopMenuBar(
        buttonSize: Size(96.zR, 96.zR),
        config: widget.config,
        visibilityNotifier: barVisibilityNotifier,
        restartHideTimerNotifier: barRestartHideTimerNotifier,
        height: 88.zR,
        backgroundColor: topMenuBarColor(),
        chatViewVisibleNotifier: chatViewVisibleNotifier,
        popUpManager: popUpManager,
      ),
    );
  }

  Color? topMenuBarColor() {
    if (widget.config.topMenuBarConfig.backgroundColor != null) {
      return widget.config.topMenuBarConfig.backgroundColor;
    } else {
      return isLightStyle ? null : const Color(0xff262A2D);
    }
  }

  Widget bottomMenuBar() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: isLightStyle ? 10 : 0,
      child: ZegoBottomMenuBar(
        buttonSize: Size(96.zR, 96.zR),
        config: widget.config,
        visibilityNotifier: barVisibilityNotifier,
        restartHideTimerNotifier: barRestartHideTimerNotifier,
        height: isLightStyle ? (96.zR + 2 * 3) : 208.zR,
        backgroundColor: bottomMenuBarColor(),
        borderRadius: isLightStyle ? null : 32.zR,
        chatViewVisibleNotifier: chatViewVisibleNotifier,
        popUpManager: popUpManager,
      ),
    );
  }

  Color? bottomMenuBarColor() {
    if (widget.config.bottomMenuBarConfig.backgroundColor != null) {
      return widget.config.bottomMenuBarConfig.backgroundColor;
    } else {
      return isLightStyle ? null : ZegoUIKitDefaultTheme.viewBackgroundColor;
    }
  }

  Future<bool> onLeaveConfirmation(BuildContext context) async {
    if (widget.config.leaveConfirmDialogInfo == null) {
      return true;
    }

    return showAlertDialog(
      context,
      widget.config.leaveConfirmDialogInfo!.title,
      widget.config.leaveConfirmDialogInfo!.message,
      [
        CupertinoDialogAction(
          child: Text(
            widget.config.leaveConfirmDialogInfo!.cancelButtonName,
            style: TextStyle(fontSize: 26.zR, color: const Color(0xff0055FF)),
          ),
          onPressed: () {
            //  pop this dialog
            Navigator.of(
              context,
              rootNavigator: widget.config.rootNavigator,
            ).pop(false);
          },
        ),
        CupertinoDialogAction(
          child: Text(
            widget.config.leaveConfirmDialogInfo!.confirmButtonName,
            style: TextStyle(fontSize: 26.zR, color: Colors.white),
          ),
          onPressed: () {
            //  pop this dialog
            Navigator.of(
              context,
              rootNavigator: widget.config.rootNavigator,
            ).pop(true);
          },
        ),
      ],
    );
  }

  Widget audioVideoViewForeground(
    BuildContext context,
    Size size,
    ZegoUIKitUser? user,
    Map<String, dynamic> extraInfo,
  ) {
    if (extraInfo[ZegoViewBuilderMapExtraInfoKey.isScreenSharingView.name]
            as bool? ??
        false) {
      return Container();
    }

    return Stack(
      children: [
        widget.config.audioVideoViewConfig.foregroundBuilder?.call(
              context,
              size,
              user,
              extraInfo,
            ) ??
            Container(color: Colors.transparent),
        ZegoAudioVideoForeground(
          size: size,
          user: user,
          showMicrophoneStateOnView:
              widget.config.audioVideoViewConfig.showMicrophoneStateOnView,
          showCameraStateOnView:
              widget.config.audioVideoViewConfig.showCameraStateOnView,
          showUserNameOnView:
              widget.config.audioVideoViewConfig.showUserNameOnView,
        ),
      ],
    );
  }

  Widget audioVideoViewBackground(
    BuildContext context,
    Size size,
    ZegoUIKitUser? user,
    Map<String, dynamic> extraInfo,
  ) {
    const backgroundColor = Color(0xff4A4B4D);

    return Stack(
      children: [
        Container(color: backgroundColor),
        widget.config.audioVideoViewConfig.backgroundBuilder?.call(
              context,
              size,
              user,
              extraInfo,
            ) ??
            Container(color: Colors.transparent),
      ],
    );
  }

  void onMeRemovedFromRoom(String fromUserID) {
    ZegoLoggerService.logInfo(
      'local user removed by $fromUserID',
      tag: 'call',
      subTag: 'prebuilt',
    );

    ///more button, member list, chat dialog
    popUpManager.autoPop(context, widget.config.rootNavigator);

    if (null != widget.config.onMeRemovedFromRoom) {
      widget.config.onMeRemovedFromRoom!.call(fromUserID);
    } else {
      //  pop this dialog
      Navigator.of(
        context,
        rootNavigator: widget.config.rootNavigator,
      ).pop(true);
    }
  }
}
