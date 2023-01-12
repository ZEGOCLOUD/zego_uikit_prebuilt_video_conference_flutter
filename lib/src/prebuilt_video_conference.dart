// Dart imports:
import 'dart:convert';
import 'dart:core';
import 'dart:developer';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:zego_uikit/zego_uikit.dart';

// Project imports:
import 'components/components.dart';
import 'prebuilt_video_conference_config.dart';

class ZegoUIKitPrebuiltVideoConference extends StatefulWidget {
  const ZegoUIKitPrebuiltVideoConference({
    Key? key,
    required this.appID,
    required this.appSign,
    required this.conferenceID,
    required this.userID,
    required this.userName,
    this.tokenServerUrl = '',
    required this.config,
  }) : super(key: key);

  /// you need to fill in the appID you obtained from console.zegocloud.com
  final int appID;

  /// You can customize the conferenceID arbitrarily,
  /// just need to know: users who use the same conferenceID can talk with each other.
  final String conferenceID;

  /// for Android/iOS
  /// you need to fill in the appID you obtained from console.zegocloud.com
  final String appSign;

  /// tokenServerUrl is only for web.
  /// If you have to support Web and Android, iOS, then you can use it like this
  /// ```
  ///   ZegoUIKitPrebuiltVideoConference(
  ///     appID: appID,
  ///     appSign: kIsWeb ? '' : appSign,
  ///     userID: userID,
  ///     userName: userName,
  ///     tokenServerUrl: kIsWeb ? tokenServerUrl：'',
  ///   );
  /// ```
  final String tokenServerUrl;

  /// local user info
  final String userID;
  final String userName;

  final ZegoUIKitPrebuiltVideoConferenceConfig config;

  @override
  State<ZegoUIKitPrebuiltVideoConference> createState() =>
      _ZegoUIKitPrebuiltVideoConferenceState();
}

class _ZegoUIKitPrebuiltVideoConferenceState
    extends State<ZegoUIKitPrebuiltVideoConference>
    with SingleTickerProviderStateMixin {
  var barVisibilityNotifier = ValueNotifier<bool>(true);
  var barRestartHideTimerNotifier = ValueNotifier<int>(0);
  var chatViewVisibleNotifier = ValueNotifier<bool>(false);

  bool get isLightStyle =>
      ZegoMenuBarStyle.light == widget.config.bottomMenuBarConfig.style;

  @override
  void initState() {
    super.initState();

    ZegoUIKit().getZegoUIKitVersion().then((version) {
      log("version: zego_uikit_prebuilt_video_conference:1.1.12; $version");
    });

    initContext();
  }

  @override
  void dispose() async {
    super.dispose();

    await ZegoUIKit().leaveRoom();
    // await ZegoUIKit().uninit();
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
        child: ScreenUtilInit(
          designSize: const Size(750, 1334),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return clickListener(
                  child: Stack(
                    children: [
                      audioVideoContainer(constraints.maxHeight),
                      widget.config.topMenuBarConfig.isVisible
                          ? topMenuBar()
                          : Container(),
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

    ZegoUIKitPrebuiltVideoConferenceConfig config = widget.config;
    if (!kIsWeb) {
      assert(widget.appSign.isNotEmpty);
      initPermissions().then((value) {
        ZegoUIKit().login(widget.userID, widget.userName).then((value) {
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
              ..setAudioOutputToSpeaker(config.useSpeakerWhenJoining)
              ..joinRoom(widget.conferenceID);
          });
        });
      });
    } else {
      assert(widget.tokenServerUrl.isNotEmpty);
      ZegoUIKit().login(widget.userID, widget.userName).then((value) {
        ZegoUIKit()
            .init(appID: widget.appID, tokenServerUrl: widget.tokenServerUrl)
            .then((value) {
          ZegoUIKit()
            ..updateVideoViewMode(
                config.audioVideoViewConfig.useVideoViewAspectFill)
            ..enableVideoMirroring(config.audioVideoViewConfig.isVideoMirror)
            ..turnCameraOn(config.turnOnCameraWhenJoining)
            ..turnMicrophoneOn(config.turnOnMicrophoneWhenJoining)
            ..setAudioOutputToSpeaker(config.useSpeakerWhenJoining);

          getToken(widget.userID).then((token) {
            assert(token.isNotEmpty);
            ZegoUIKit().joinRoom(widget.conferenceID, token: token);
          });
        });
      });
    }
  }

  void correctConfigValue() {
    if (widget.config.bottomMenuBarConfig.maxCount > 5) {
      widget.config.bottomMenuBarConfig.maxCount = 5;
      ZegoLoggerService.logInfo(
        'menu bar buttons limited count\'s value  is exceeding the maximum limit',
        tag: "video conference",
        subTag: "prebuilt",
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

  Widget audioVideoContainer(double height) {
    return Positioned(
      top: 0,
      left: 0,
      child: SizedBox(
        width: 750.w,
        height: height,
        child: ZegoAudioVideoContainer(
          layout: widget.config.layout!,
          backgroundBuilder: audioVideoViewBackground,
          foregroundBuilder: audioVideoViewForeground,
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
          left: 32.r,
          bottom: isBarVisible ? 232.r : 24.r,
          child: ConstrainedBox(
            constraints: BoxConstraints.loose(Size(540.r, 400.r)),
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
      BuildContext context, ZegoInRoomMessage message, Map extraInfo) {
    return ZegoInRoomNotificationViewItem(
      maxLines: 3,
      user: message.user,
      message: message.message,
      isHorizontal: false,
    );
  }

  Widget notificationUserJoinItemBuilder(
      BuildContext context, ZegoUIKitUser user, Map extraInfo) {
    return ZegoInRoomNotificationViewItem(
      user: user,
      message: "joins the conference.",
      isHorizontal: false,
    );
  }

  Widget notificationUserLeaveItemBuilder(
      BuildContext context, ZegoUIKitUser user, Map extraInfo) {
    return ZegoInRoomNotificationViewItem(
      user: user,
      message: "left the conference.",
      isHorizontal: false,
    );
  }

  Widget topMenuBar() {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      child: ZegoTopMenuBar(
        buttonSize: Size(96.r, 96.r),
        config: widget.config,
        visibilityNotifier: barVisibilityNotifier,
        restartHideTimerNotifier: barRestartHideTimerNotifier,
        height: 88.r,
        backgroundColor: isLightStyle ? null : const Color(0xff262A2D),
        chatViewVisibleNotifier: chatViewVisibleNotifier,
      ),
    );
  }

  Widget bottomMenuBar() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: isLightStyle ? 10 : 0,
      child: ZegoBottomMenuBar(
        buttonSize: Size(96.r, 96.r),
        config: widget.config,
        visibilityNotifier: barVisibilityNotifier,
        restartHideTimerNotifier: barRestartHideTimerNotifier,
        height: isLightStyle ? (96.r + 2 * 3) : 208.r,
        backgroundColor:
            isLightStyle ? null : ZegoUIKitDefaultTheme.viewBackgroundColor,
        borderRadius: isLightStyle ? null : 32.r,
        chatViewVisibleNotifier: chatViewVisibleNotifier,
      ),
    );
  }

  /// Get your token from tokenServer
  Future<String> getToken(String userID) async {
    final response = await http
        .get(Uri.parse('${widget.tokenServerUrl}/access_token?uid=$userID'));
    if (response.statusCode == 200) {
      final jsonObj = json.decode(response.body);
      return jsonObj['token'];
    } else {
      return "";
    }
  }

  Future<bool> onLeaveConfirmation(BuildContext context) async {
    if (widget.config.leaveConfirmDialogInfo == null) {
      return true;
    }

    return await showAlertDialog(
      context,
      widget.config.leaveConfirmDialogInfo!.title,
      widget.config.leaveConfirmDialogInfo!.message,
      [
        CupertinoDialogAction(
          child: Text(
            widget.config.leaveConfirmDialogInfo!.cancelButtonName,
            style: TextStyle(fontSize: 26.r, color: const Color(0xff0055FF)),
          ),
          onPressed: () {
            //  pop this dialog
            Navigator.of(context).pop(false);
          },
        ),
        CupertinoDialogAction(
          child: Text(
            widget.config.leaveConfirmDialogInfo!.confirmButtonName,
            style: TextStyle(fontSize: 26.r, color: Colors.white),
          ),
          onPressed: () {
            //  pop this dialog
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }

  Widget audioVideoViewForeground(
      BuildContext context, Size size, ZegoUIKitUser? user, Map extraInfo) {
    if (extraInfo[ZegoViewBuilderMapExtraInfoKey.isScreenSharingView.name]
            as bool? ??
        false) {
      return Container();
    }

    return Stack(
      children: [
        widget.config.audioVideoViewConfig.foregroundBuilder
                ?.call(context, size, user, extraInfo) ??
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
      BuildContext context, Size size, ZegoUIKitUser? user, Map extraInfo) {
    var backgroundColor = const Color(0xff4A4B4D);

    return Stack(
      children: [
        Container(color: backgroundColor),
        widget.config.audioVideoViewConfig.backgroundBuilder
                ?.call(context, size, user, extraInfo) ??
            Container(color: Colors.transparent),
      ],
    );
  }
}
