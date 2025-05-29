// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

/// Here is the simplest demo.
///
/// Please follow the link below to see more details.
/// https://github.com/ZEGOCLOUD/zego_uikit_prebuilt_video_conference_example_flutter

Widget liveAudioRoomPage({required bool isHost}) {
  return ZegoUIKitPrebuiltVideoConference(
    appID: -1, // your AppID,
    appSign: 'your AppSign',
    userID: 'local user id',
    userName: 'local user name',
    conferenceID: 'conference id',
    config: ZegoUIKitPrebuiltVideoConferenceConfig(),
  );
}
