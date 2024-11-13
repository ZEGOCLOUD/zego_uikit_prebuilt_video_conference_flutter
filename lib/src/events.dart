// Project imports:
import 'package:zego_uikit_prebuilt_video_conference/src/config.dart';

/// You can listen to events that you are interested in here, such as Co-hosting
class ZegoUIKitPrebuiltVideoConferenceEvents {
  /// events about duration
  ZegoVideoConferenceDurationEvents duration;

  ZegoUIKitPrebuiltVideoConferenceEvents({
    ZegoVideoConferenceDurationEvents? duration,
  }) : duration = duration ?? ZegoVideoConferenceDurationEvents();
}

class ZegoVideoConferenceDurationEvents {
  ZegoVideoConferenceDurationEvents({
    this.onUpdated,
  });

  /// Call timing callback function, called every second.
  ///
  /// Example: Set to automatically leave after 5 minutes.
  ///```dart
  /// ..duration.onUpdate = (Duration duration) {
  ///   if (duration.inSeconds >= 5 * 60) {
  ///     ZegoUIKitPrebuiltVideoConferenceController().leave(context);
  ///   }
  /// }
  /// ```
  ///
  /// [ZegoVideoConferenceDurationConfig]
  void Function(Duration)? onUpdated;
}
