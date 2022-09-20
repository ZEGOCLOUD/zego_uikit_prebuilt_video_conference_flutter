// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zego_uikit/zego_uikit.dart';

class ZegoMessageListSheetItem extends StatefulWidget {
  const ZegoMessageListSheetItem({
    Key? key,
    required this.message,
    required this.avatarBuilder,
  }) : super(key: key);

  final ZegoInRoomMessage message;
  final AudioVideoViewAvatarBuilder? avatarBuilder;

  @override
  State<ZegoMessageListSheetItem> createState() => _ZegoCallMessageListState();
}

class _ZegoCallMessageListState extends State<ZegoMessageListSheetItem> {
  bool isLocalSender = false;

  @override
  void initState() {
    super.initState();

    isLocalSender = widget.message.sender.id == ZegoUIKit().getLocalUser().id;
  }

  @override
  Widget build(BuildContext context) {
    var rowItems = [
      avatar(),
      SizedBox(width: 24.r),
      Column(
        crossAxisAlignment:
            isLocalSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          topInfo(),
          SizedBox(height: 6.r),
          content(),
        ],
      ),
    ];

    return Row(
      mainAxisAlignment:
          isLocalSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: isLocalSender ? List.from(rowItems.reversed) : rowItems,
    );
  }

  Widget avatar() {
    return widget.avatarBuilder
            ?.call(context, Size(56.r, 56.r), widget.message.sender, {}) ??
        circleName(context, Size(56.r, 56.r), widget.message.sender);
  }

  Widget content() {
    return IntrinsicWidth(
      //  automatic shrinkage width
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 530.r,
          minHeight: 40.r,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: isLocalSender
                ? const Color(0xff0055FF).withOpacity(0.3)
                : const Color(0xff4a4b43).withOpacity(0.3),
            borderRadius: BorderRadius.all(Radius.circular(18.r)),
          ),
          padding: EdgeInsets.symmetric(horizontal: 28.0.r, vertical: 18.0.r),
          child: Align(
            alignment: isLocalSender ? Alignment.topRight : Alignment.topLeft,
            child: Text(
              widget.message.message,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontSize: 32.r,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget topInfo() {
    var sendTime = DateTime.fromMillisecondsSinceEpoch(widget.message.sendTime);
    var formatSendTime =
        "${sendTime.hour > 12 ? "P.M:" : "A.M"} ${sendTime.hour}:${sendTime.minute}";

    var topInfoChildren = [
      Text(
        widget.message.sender.name,
        style: TextStyle(
          color: const Color(0xffCDCDCD),
          fontSize: 24.r,
          fontWeight: FontWeight.w400,
        ),
      ),
      SizedBox(width: 14.r),
      Text(
        formatSendTime,
        style: TextStyle(
          color: const Color(0xffA4A4A4),
          fontSize: 24.r,
          fontWeight: FontWeight.w400,
        ),
      ),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children:
          isLocalSender ? List.from(topInfoChildren.reversed) : topInfoChildren,
    );
  }

  Widget circleName(BuildContext context, Size size, ZegoUIKitUser? user) {
    var userName = user?.name ?? "";
    return Container(
      width: size.width,
      height: size.height,
      decoration:
          const BoxDecoration(color: Color(0xffDBDDE3), shape: BoxShape.circle),
      child: Center(
        child: Text(
          userName.isNotEmpty ? userName.characters.first : "",
          style: TextStyle(
            fontSize: 24.r,
            fontWeight: FontWeight.w600,
            color: const Color(0xff222222),
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
