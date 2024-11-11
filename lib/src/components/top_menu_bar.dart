// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:zego_uikit/zego_uikit.dart';

// Project imports:
import 'package:zego_uikit_prebuilt_video_conference/src/components/icon_defines.dart';
import 'package:zego_uikit_prebuilt_video_conference/src/components/member/member_list_button.dart';
import 'package:zego_uikit_prebuilt_video_conference/src/components/message/in_room_message_button.dart';
import 'package:zego_uikit_prebuilt_video_conference/src/components/pop_up_manager.dart';
import 'package:zego_uikit_prebuilt_video_conference/src/config.dart';
import 'package:zego_uikit_prebuilt_video_conference/src/defines.dart';

/// @nodoc
class ZegoTopMenuBar extends StatefulWidget {
  final ZegoUIKitPrebuiltVideoConferenceConfig config;
  final Size buttonSize;
  final ValueNotifier<bool> visibilityNotifier;
  final int autoHideSeconds;
  final ValueNotifier<int> restartHideTimerNotifier;

  final double? height;
  final double? borderRadius;
  final Color? backgroundColor;

  final ValueNotifier<bool> chatViewVisibleNotifier;
  final ZegoPopUpManager popUpManager;

  const ZegoTopMenuBar({
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
  State<ZegoTopMenuBar> createState() => _ZegoTopMenuBarState();
}

/// @nodoc
class _ZegoTopMenuBarState extends State<ZegoTopMenuBar> {
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
      endOffset: const Offset(0.0, -2.0),
      child: Container(
        height: widget.height ?? (widget.buttonSize.height + 2 * 3),
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? Colors.transparent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(widget.borderRadius ?? 0),
            topRight: Radius.circular(widget.borderRadius ?? 0),
          ),
        ),
        child: Row(
          children: [
            title(),
            Expanded(child: Container()),
            rightBar(),
          ],
        ),
      ),
    );
  }

  Widget title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 27.zR,
        ),
        Text(
          widget.config.topMenuBarConfig.title,
          style: TextStyle(
              color: Colors.white,
              fontSize: 36.zR,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget rightBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ...getDisplayButtons(context),
        SizedBox(
          width: 27.zR,
        )
      ],
    );
  }

  List<Widget> getDisplayButtons(BuildContext context) {
    final buttons = [
      ...getDefaultButtons(context),
      ...widget.config.topMenuBarConfig.extendButtons
          .map((extendButton) => buttonWrapper(child: extendButton))
    ];

    /// limited item count display on menu bar,
    /// if this count is exceeded, Trim down the extra buttons
    const maxCount = 3;
    if (buttons.length > maxCount) {
      return buttons.sublist(0, maxCount);
    }

    return buttons;
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
    if (!widget.config.topMenuBarConfig.hideAutomatically) {
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

  List<Widget> getDefaultButtons(BuildContext context) {
    if (widget.config.topMenuBarConfig.buttons.isEmpty) {
      return [];
    }

    return widget.config.topMenuBarConfig.buttons
        .map((type) => buttonWrapper(
              child: generateDefaultButtonsByEnum(context, type),
            ))
        .toList();
  }

  Widget generateDefaultButtonsByEnum(
      BuildContext context, ZegoMenuBarButtonName type) {
    final buttonSize = Size(70.zR, 70.zR);
    final iconSize = Size(64.zR, 64.zR);

    switch (type) {
      case ZegoMenuBarButtonName.toggleMicrophoneButton:
        return ZegoToggleMicrophoneButton(
          buttonSize: buttonSize,
          iconSize: iconSize,
          normalIcon: ButtonIcon(
            icon: PrebuiltVideoConferenceImage.asset(
                PrebuiltVideoConferenceIconUrls.topMicNormal),
            backgroundColor: Colors.transparent,
          ),
          offIcon: ButtonIcon(
            icon: PrebuiltVideoConferenceImage.asset(
                PrebuiltVideoConferenceIconUrls.topMicOff),
            backgroundColor: Colors.transparent,
          ),
          defaultOn: widget.config.turnOnMicrophoneWhenJoining,
        );
      case ZegoMenuBarButtonName.switchAudioOutputButton:
        return ZegoSwitchAudioOutputButton(
          buttonSize: buttonSize,
          iconSize: iconSize,
          speakerIcon: ButtonIcon(
            icon: PrebuiltVideoConferenceImage.asset(
                PrebuiltVideoConferenceIconUrls.topSpeakerNormal),
            backgroundColor: Colors.transparent,
          ),
          headphoneIcon: ButtonIcon(
            icon: PrebuiltVideoConferenceImage.asset(
                PrebuiltVideoConferenceIconUrls.topSpeakerOff),
            backgroundColor: Colors.transparent,
          ),
          bluetoothIcon: ButtonIcon(
            icon: PrebuiltVideoConferenceImage.asset(
                PrebuiltVideoConferenceIconUrls.topSpeakerBluetooth),
            backgroundColor: Colors.transparent,
          ),
          defaultUseSpeaker: widget.config.useSpeakerWhenJoining,
        );
      case ZegoMenuBarButtonName.toggleCameraButton:
        return ZegoToggleCameraButton(
          buttonSize: buttonSize,
          iconSize: iconSize,
          normalIcon: ButtonIcon(
            icon: PrebuiltVideoConferenceImage.asset(
                PrebuiltVideoConferenceIconUrls.topCameraNormal),
            backgroundColor: Colors.transparent,
          ),
          offIcon: ButtonIcon(
            icon: PrebuiltVideoConferenceImage.asset(
                PrebuiltVideoConferenceIconUrls.topCameraOff),
            backgroundColor: Colors.transparent,
          ),
          defaultOn: widget.config.turnOnCameraWhenJoining,
        );
      case ZegoMenuBarButtonName.switchCameraButton:
        return ZegoSwitchCameraButton(
          buttonSize: buttonSize,
          iconSize: iconSize,
          icon: ButtonIcon(
            icon: PrebuiltVideoConferenceImage.asset(
                PrebuiltVideoConferenceIconUrls.topCameraOverturn),
            backgroundColor: Colors.transparent,
          ),
          defaultUseFrontFacingCamera: ZegoUIKit()
              .getUseFrontFacingCameraStateNotifier(
                  ZegoUIKit().getLocalUser().id)
              .value,
        );
      case ZegoMenuBarButtonName.leaveButton:
        return ZegoLeaveButton(
          buttonSize: buttonSize,
          iconSize: iconSize,
          icon: ButtonIcon(
              icon: PrebuiltVideoConferenceImage.asset(
                  PrebuiltVideoConferenceIconUrls.topLeave),
              backgroundColor: Colors.transparent),
          onLeaveConfirmation: (context) async {
            return widget.config.onLeaveConfirmation!(context);
          },
          onPress: () {
            if (widget.config.onLeave != null) {
              widget.config.onLeave!.call();
            } else {
              /// default behaviour if hand up is null, back to previous page
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
          icon: ButtonIcon(
            icon: PrebuiltVideoConferenceImage.asset(
                PrebuiltVideoConferenceIconUrls.topMemberNormal),
            backgroundColor: Colors.transparent,
          ),
          rootNavigator: widget.config.rootNavigator,
          popUpManager: widget.popUpManager,
        );
      case ZegoMenuBarButtonName.chatButton:
        return ZegoInRoomMessageButton(
          buttonSize: buttonSize,
          iconSize: iconSize,
          icon: ButtonIcon(
            icon: PrebuiltVideoConferenceImage.asset(
                PrebuiltVideoConferenceIconUrls.topMemberIM),
            backgroundColor: Colors.transparent,
          ),
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
