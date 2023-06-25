// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:zego_uikit/zego_uikit.dart';

// Project imports:
import 'package:zego_uikit_prebuilt_video_conference/src/components/member/member_list_button.dart';
import 'package:zego_uikit_prebuilt_video_conference/src/components/message/in_room_message_button.dart';
import 'package:zego_uikit_prebuilt_video_conference/src/components/pop_up_manager.dart';
import 'package:zego_uikit_prebuilt_video_conference/src/prebuilt_video_conference_config.dart';
import 'package:zego_uikit_prebuilt_video_conference/src/prebuilt_video_conference_defines.dart';

/// @nodoc
class ZegoBottomMenuBar extends StatefulWidget {
  final ZegoUIKitPrebuiltVideoConferenceConfig config;
  final Size buttonSize;
  final int autoHideSeconds;
  final ValueNotifier<bool> visibilityNotifier;
  final ValueNotifier<int> restartHideTimerNotifier;

  final double? height;
  final double? borderRadius;
  final Color? backgroundColor;

  final ValueNotifier<bool> chatViewVisibleNotifier;
  final ZegoPopUpManager popUpManager;

  const ZegoBottomMenuBar({
    Key? key,
    required this.config,
    required this.visibilityNotifier,
    required this.restartHideTimerNotifier,
    required this.chatViewVisibleNotifier,
    required this.popUpManager,
    this.autoHideSeconds = 3,
    this.buttonSize = const Size(60, 60),
    this.height,
    this.borderRadius,
    this.backgroundColor,
  }) : super(key: key);

  @override
  State<ZegoBottomMenuBar> createState() => _ZegoBottomMenuBarState();
}

/// @nodoc
class _ZegoBottomMenuBarState extends State<ZegoBottomMenuBar> {
  Timer? hideTimerOfMenuBar;

  @override
  void initState() {
    super.initState();

    countdownToHideBar();
    widget.restartHideTimerNotifier.addListener(onHideTimerRestartNotify);

    widget.visibilityNotifier.addListener(onVisibilityNotifierChanged);
  }

  @override
  void dispose() {
    stopCountdownHideBar();
    widget.restartHideTimerNotifier.removeListener(onHideTimerRestartNotify);

    widget.visibilityNotifier.removeListener(onVisibilityNotifierChanged);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueNotifierSliderVisibility(
      visibilityNotifier: widget.visibilityNotifier,
      child: Container(
        height: widget.height ?? (widget.buttonSize.height + 2 * 3),
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? Colors.transparent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(widget.borderRadius ?? 0),
            topRight: Radius.circular(widget.borderRadius ?? 0),
          ),
        ),
        child: CustomScrollView(
          scrollDirection: Axis.horizontal,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: getDisplayButtons(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getDisplayButtons(BuildContext context) {
    final buttonList = <Widget>[
      ...getDefaultButtons(context),
      ...widget.config.bottomMenuBarConfig.extendButtons
          .map((extendButton) => buttonWrapper(child: extendButton))
    ];

    var displayButtonList = <Widget>[];
    if (buttonList.length > widget.config.bottomMenuBarConfig.maxCount) {
      /// the list count exceeds the limit, so divided into two parts,
      /// one part display in the Menu bar, the other part display in the menu with more buttons
      displayButtonList =
          buttonList.sublist(0, widget.config.bottomMenuBarConfig.maxCount - 1);

      buttonList.removeRange(0, widget.config.bottomMenuBarConfig.maxCount - 1);
      displayButtonList.add(
        buttonWrapper(
          child: ZegoMoreButton(menuButtonListFunc: () {
            final buttonList = <Widget>[
              ...getDefaultButtons(context, cameraDefaultValueFunc: () {
                return ZegoUIKit()
                    .getCameraStateNotifier(ZegoUIKit().getLocalUser().id)
                    .value;
              }, microphoneDefaultValueFunc: () {
                return ZegoUIKit()
                    .getMicrophoneStateNotifier(ZegoUIKit().getLocalUser().id)
                    .value;
              }),
              ...widget.config.bottomMenuBarConfig.extendButtons
                  .map((extendButton) => buttonWrapper(child: extendButton))
            ]..removeRange(0, widget.config.bottomMenuBarConfig.maxCount - 1);

            return buttonList;
          }),
        ),
      );
    } else {
      displayButtonList = buttonList;
    }

    return displayButtonList;
  }

  void onHideTimerRestartNotify() {
    stopCountdownHideBar();
    countdownToHideBar();
  }

  void onVisibilityNotifierChanged() {
    if (widget.visibilityNotifier.value) {
      countdownToHideBar();
    } else {
      stopCountdownHideBar();
    }
  }

  void countdownToHideBar() {
    if (!widget.config.bottomMenuBarConfig.hideAutomatically) {
      return;
    }

    hideTimerOfMenuBar?.cancel();
    hideTimerOfMenuBar = Timer(Duration(seconds: widget.autoHideSeconds), () {
      widget.visibilityNotifier.value = false;
    });
  }

  void stopCountdownHideBar() {
    hideTimerOfMenuBar?.cancel();
  }

  Widget buttonWrapper({required Widget child}) {
    return SizedBox(
      width: widget.buttonSize.width,
      height: widget.buttonSize.height,
      child: child,
    );
  }

  List<Widget> getDefaultButtons(
    BuildContext context, {
    bool Function()? cameraDefaultValueFunc,
    bool Function()? microphoneDefaultValueFunc,
  }) {
    if (widget.config.bottomMenuBarConfig.buttons.isEmpty) {
      return [];
    }

    return widget.config.bottomMenuBarConfig.buttons
        .map((type) => buttonWrapper(
              child: generateDefaultButtonsByEnum(
                context,
                type,
                cameraDefaultValueFunc: cameraDefaultValueFunc,
                microphoneDefaultValueFunc: microphoneDefaultValueFunc,
              ),
            ))
        .toList();
  }

  Widget generateDefaultButtonsByEnum(
    BuildContext context,
    ZegoMenuBarButtonName type, {
    bool Function()? cameraDefaultValueFunc,
    bool Function()? microphoneDefaultValueFunc,
  }) {
    final buttonSize = Size(96.zR, 96.zR);
    final iconSize = Size(56.zR, 56.zR);

    switch (type) {
      case ZegoMenuBarButtonName.toggleMicrophoneButton:
        return ZegoToggleMicrophoneButton(
          buttonSize: buttonSize,
          iconSize: iconSize,
          defaultOn: microphoneDefaultValueFunc?.call() ??
              widget.config.turnOnMicrophoneWhenJoining,
        );
      case ZegoMenuBarButtonName.switchAudioOutputButton:
        return ZegoSwitchAudioOutputButton(
          buttonSize: buttonSize,
          iconSize: iconSize,
          defaultUseSpeaker: widget.config.useSpeakerWhenJoining,
        );
      case ZegoMenuBarButtonName.toggleCameraButton:
        return ZegoToggleCameraButton(
          buttonSize: buttonSize,
          iconSize: iconSize,
          defaultOn: cameraDefaultValueFunc?.call() ??
              widget.config.turnOnCameraWhenJoining,
        );
      case ZegoMenuBarButtonName.switchCameraButton:
        return ZegoSwitchCameraButton(
          buttonSize: buttonSize,
          iconSize: iconSize,
          defaultUseFrontFacingCamera: ZegoUIKit()
              .getUseFrontFacingCameraStateNotifier(
                  ZegoUIKit().getLocalUser().id)
              .value,
        );
      case ZegoMenuBarButtonName.leaveButton:
        return ZegoLeaveButton(
          buttonSize: buttonSize,
          iconSize: iconSize,
          onLeaveConfirmation: (context) async {
            return widget.config.onLeaveConfirmation!(context);
          },
          onPress: () {
            if (widget.config.onLeave != null) {
              widget.config.onLeave!.call();
            } else {
              Navigator.of(
                context,
                rootNavigator: widget.config.rootNavigator,
              ).pop();
            }
          },
        );
      case ZegoMenuBarButtonName.showMemberListButton:
        return ZegoMemberListButton(
          config: widget.config.memberListConfig,
          avatarBuilder: widget.config.avatarBuilder,
          buttonSize: buttonSize,
          iconSize: iconSize,
          rootNavigator: widget.config.rootNavigator,
          popUpManager: widget.popUpManager,
        );
      case ZegoMenuBarButtonName.chatButton:
        return ZegoInRoomMessageButton(
          buttonSize: buttonSize,
          iconSize: iconSize,
          avatarBuilder: widget.config.avatarBuilder,
          itemBuilder: widget.config.chatViewConfig.itemBuilder,
          viewVisibleNotifier: widget.chatViewVisibleNotifier,
          popUpManager: widget.popUpManager,
        );
      case ZegoMenuBarButtonName.toggleScreenSharingButton:
        return ZegoScreenSharingToggleButton(
          buttonSize: buttonSize,
          iconSize: iconSize,
          onPressed: (isScreenSharing) {},
        );
    }
  }
}
