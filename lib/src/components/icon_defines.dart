// Flutter imports:
import 'package:flutter/material.dart';

class PrebuiltVideoConferenceImage {
  static Image asset(String name) {
    return Image.asset(name, package: "zego_uikit_prebuilt_video_conference");
  }
}

class PrebuiltVideoConferenceIconUrls {
  static const String back = 'assets/icons/back.png';
  static const String im = 'assets/icons/im.png';

  static const String topMemberIM = 'assets/icons/top_im.png';
  static const String topMemberNormal = 'assets/icons/top_member_normal.png';
  static const String topCameraOverturn =
      'assets/icons/top_camera_overturn.png';
  static const String topCameraNormal = 'assets/icons/top_camera_normal.png';
  static const String topCameraOff = 'assets/icons/top_camera_off.png';
  static const String topLeave = 'assets/icons/top_leave.png';
  static const String topMicNormal = 'assets/icons/top_mic_normal.png';
  static const String topMicOff = 'assets/icons/top_mic_off.png';
  static const String topSpeakerNormal = 'assets/icons/top_speaker_normal.png';
  static const String topSpeakerOff = 'assets/icons/top_speaker_off.png';
  static const String topSpeakerBluetooth =
      'assets/icons/top_speaker_bluetooth.png';
}
