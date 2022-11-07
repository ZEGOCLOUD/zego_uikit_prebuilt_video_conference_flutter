// Dart imports:
import 'dart:math' as math;

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zego_uikit/zego_uikit.dart';

// Project imports:
import 'package:zego_uikit_prebuilt_video_conference/src/components/icon_defines.dart';
import 'in_room_message_list_sheet.dart';

/// switch cameras
class ZegoInRoomMessageButton extends StatefulWidget {
  const ZegoInRoomMessageButton({
    Key? key,
    this.afterClicked,
    this.icon,
    this.iconSize,
    this.buttonSize,
    this.avatarBuilder,
    this.itemBuilder,
    required this.viewVisibleNotifier,
  }) : super(key: key);

  final ButtonIcon? icon;

  ///  You can do what you want after pressed.
  final VoidCallback? afterClicked;

  /// the size of button's icon
  final Size? iconSize;

  /// the size of button
  final Size? buttonSize;

  final ZegoAvatarBuilder? avatarBuilder;
  final ZegoInRoomMessageItemBuilder? itemBuilder;

  final ValueNotifier<bool> viewVisibleNotifier;

  @override
  State<ZegoInRoomMessageButton> createState() =>
      _ZegoInRoomMessageButtonState();
}

class _ZegoInRoomMessageButtonState extends State<ZegoInRoomMessageButton> {
  /// keep scroll position
  var scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Size containerSize = widget.buttonSize ?? Size(96.r, 96.r);
    Size sizeBoxSize = widget.iconSize ?? Size(56.r, 56.r);

    return GestureDetector(
      onTap: () {
        showMessageSheet(
          context,
          avatarBuilder: widget.avatarBuilder,
          itemBuilder: widget.itemBuilder,
          visibleNotifier: widget.viewVisibleNotifier,
          scrollController: scrollController,
        );

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
          borderRadius: BorderRadius.all(
            Radius.circular(
                math.min(containerSize.width, containerSize.height) / 2),
          ),
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
