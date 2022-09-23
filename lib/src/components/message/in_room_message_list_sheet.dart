// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zego_uikit/zego_uikit.dart';

// Project imports:
import 'package:zego_uikit_prebuilt_video_conference/src/components/icon_defines.dart';

import 'in_room_message_input_board.dart';

class ZegoVideoConferenceMessageListSheet extends StatefulWidget {
  const ZegoVideoConferenceMessageListSheet({
    Key? key,
    this.avatarBuilder,
  }) : super(key: key);

  final AvatarBuilder? avatarBuilder;

  @override
  State<ZegoVideoConferenceMessageListSheet> createState() =>
      _ZegoVideoConferenceMessageListSheetState();
}

class _ZegoVideoConferenceMessageListSheetState
    extends State<ZegoVideoConferenceMessageListSheet> {
  var messageValueNotifier = ValueNotifier<String>("");

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        header(98.h),
        Positioned(
          left: 0,
          right: 0,
          top: 99.h,
          child: Container(height: 1.r, color: Colors.white),
        ),
        messageList(
          height: 1142.h - 98.h - 1.h - 110.h - 25.h * 2,
          top: 100.h + 25.h,
        ),
        bottomBar(top: 1142.h - 110.h),
      ],
    );
  }

  Widget bottomBar({required double top}) {
    return Positioned(
      left: 0,
      right: 0,
      top: top,
      child: ValueListenableBuilder<String>(
        valueListenable: messageValueNotifier,
        builder: (context, message, child) {
          return Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    ZegoInRoomMessageInputBoard(
                      placeHolder: "Send a message to everyone",
                      valueNotifier: messageValueNotifier,
                    ),
                  );
                },
                child: Container(
                  width: 604.w,
                  height: 74.h,
                  padding: EdgeInsets.symmetric(horizontal: 30.r),
                  decoration: BoxDecoration(
                    color: const Color(0xffA4A4A4),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 0.r, vertical: 25.r),
                    child: Text(
                      message.isEmpty ? "Send a message to everyone" : message,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 18.r),
              ZegoTextIconButton(
                onPressed: () {
                  if (message.isNotEmpty) {
                    ZegoUIKit().sendInRoomMessage(message);
                    messageValueNotifier.value = "";
                  }
                },
                icon: ButtonIcon(
                  icon: message.isEmpty
                      ? UIKitImage.asset(StyleIconUrls.iconSendDisable)
                      : UIKitImage.asset(StyleIconUrls.iconSend),
                ),
                iconSize: Size(40.r, 40.r),
                buttonSize: Size(68.r, 68.r),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget messageList({required double height, required double top}) {
    return Positioned(
      top: top,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.r),
        // height: height,
        child: ConstrainedBox(
          constraints: BoxConstraints.loose(Size(690.w, height)),
          child: ZegoInRoomChatView(
            avatarBuilder: widget.avatarBuilder,
          ),
        ),
      ),
    );
  }

  Widget header(double height) {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      child: SizedBox(
        height: height,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: SizedBox(
                width: 70.r,
                height: 70.r,
                child: PrebuiltVideoConferenceImage.asset(
                    PrebuiltVideoConferenceIconUrls.back),
              ),
            ),
            SizedBox(width: 10.r),
            Text(
              "Chat",
              style: TextStyle(
                fontSize: 36.0.r,
                color: const Color(0xffffffff),
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showMessageSheet(
  BuildContext context, {
  AvatarBuilder? avatarBuilder,
  required ValueNotifier<bool> visibleNotifier,
}) {
  visibleNotifier.value = true;

  showModalBottomSheet(
    backgroundColor: const Color(0xff242736).withOpacity(0.95),
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32.0),
        topRight: Radius.circular(32.0),
      ),
    ),
    isDismissible: true,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return FractionallySizedBox(
        heightFactor: 0.85,
        child: AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets,
          duration: const Duration(milliseconds: 50),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: ZegoVideoConferenceMessageListSheet(
              avatarBuilder: avatarBuilder,
            ),
          ),
        ),
      );
    },
  ).then((value) {
    visibleNotifier.value = false;
  });
}
