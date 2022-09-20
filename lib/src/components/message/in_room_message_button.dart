// Dart imports:
import 'dart:math' as math;

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zego_uikit/zego_uikit.dart';

// Project imports:
import 'package:zego_uikit_prebuilt_video_conference/src/components/icon_defines.dart';
import 'package:zego_uikit_prebuilt_video_conference/src/components/message/message_list_sheet.dart';

/// switch cameras
class ZegoInRoomMessageButton extends StatefulWidget {
  const ZegoInRoomMessageButton({
    Key? key,
    this.afterClicked,
    this.icon,
    this.iconSize,
    this.buttonSize,
  }) : super(key: key);

  final ButtonIcon? icon;

  ///  You can do what you want after clicked.
  final VoidCallback? afterClicked;

  /// the size of button's icon
  final Size? iconSize;

  /// the size of button
  final Size? buttonSize;

  @override
  State<ZegoInRoomMessageButton> createState() =>
      _ZegoInRoomMessageButtonState();
}

class _ZegoInRoomMessageButtonState extends State<ZegoInRoomMessageButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size containerSize = widget.buttonSize ?? Size(96.r, 96.r);
    Size sizeBoxSize = widget.iconSize ?? Size(56.r, 56.r);

    return GestureDetector(
      onTap: () {
        showMessageSheet(context);

        if (widget.afterClicked != null) {
          widget.afterClicked!();
        }
      },
      child: Container(
        width: containerSize.width,
        height: containerSize.height,
        decoration: BoxDecoration(
          color: widget.icon?.backgroundColor ??
              const Color(0xff2C2F3E).withOpacity(0.6),
          borderRadius: BorderRadius.all(Radius.circular(
              math.min(containerSize.width, containerSize.height) / 2)),
        ),
        child: SizedBox.fromSize(
          size: sizeBoxSize,
          child: widget.icon?.icon ??
              PrebuiltVideoConferenceImage.asset(
                  PrebuiltVideoConferenceIconUrls.im),
        ),
      ),
    );
  }
}
