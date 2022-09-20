// Flutter imports:
import 'dart:async';

import 'package:flutter/material.dart';

// Package imports:
import 'package:zego_uikit/zego_uikit.dart';

class ZegoMessageBubble extends StatefulWidget {
  const ZegoMessageBubble({
    Key? key,
  }) : super(key: key);

  @override
  State<ZegoMessageBubble> createState() => _ZegoCallMessageListState();
}

class _ZegoCallMessageListState extends State<ZegoMessageBubble> {
  List<ZegoInRoomMessage> messages = []; //  chat/enter/leave messages,
  var messageListStream = StreamController<List<ZegoInRoomMessage>>.broadcast();
  List<StreamSubscription<dynamic>> streamSubscriptions = [];
  Timer? clearTimeoutTimer;

  @override
  void initState() {
    super.initState();

    clearTimeoutTimer =
        Timer.periodic(const Duration(seconds: 1), clearTimeoutMessage);
    streamSubscriptions
        .add(ZegoUIKit().getInRoomMessageStream().listen(onInRoomMessage));
    streamSubscriptions.add(ZegoUIKit().getUserJoinStream().listen(onUserJoin));
    streamSubscriptions
        .add(ZegoUIKit().getUserLeaveStream().listen(onUserLeave));
  }

  @override
  void dispose() {
    super.dispose();

    clearTimeoutTimer?.cancel();
    for (var streamSubscription in streamSubscriptions) {
      streamSubscription.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ZegoInRoomMessageView(
      stream: messageListStream.stream,
    );
  }

  void onUserJoin(List<ZegoUIKitUser> users) {
    for (var user in users) {
      if (user.id == ZegoUIKit().getLocalUser().id) {
        continue;
      }

      var message = ZegoInRoomMessage(
        sender: user,
        message: "entered the room.",
        sendTime: DateTime.now().millisecondsSinceEpoch,
        messageID: 0,
        errorCode: 0,
      );
      messages.add(message);
    }
    broadcastStream();
  }

  void onUserLeave(List<ZegoUIKitUser> users) {
    for (var user in users) {
      if (user.id == ZegoUIKit().getLocalUser().id) {
        continue;
      }

      var message = ZegoInRoomMessage(
        sender: user,
        message: "left the room.",
        sendTime: DateTime.now().millisecondsSinceEpoch,
        messageID: 0,
        errorCode: 0,
      );
      messages.add(message);
    }
    broadcastStream();
  }

  void onInRoomMessage(ZegoInRoomMessage message) {
    if (message.sender.id == ZegoUIKit().getLocalUser().id) {
      return;
    }

    messages.add(message);
    broadcastStream();
  }

  void broadcastStream() {
    messageListStream.add(messages.take(3).toList());
    if (messages.length > 3) {
      messages.removeRange(0, messages.length - 3);
    }
  }

  void clearTimeoutMessage(Timer _) {
    if (messages.isEmpty) {
      return;
    }

    messages.removeWhere((message) {
      var isTimeoutMessage = DateTime.now()
              .difference(DateTime.fromMillisecondsSinceEpoch(message.sendTime))
              .inSeconds >
          3;
      return isTimeoutMessage;
    });

    broadcastStream();
  }
}
