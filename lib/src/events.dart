// Project imports:

/// You can listen to events that you are interested in here, such as Co-hosting
///
/// Example:
/// ```dart
/// ZegoUIKitPrebuiltVideoConferenceEvents(
///   duration: ZegoVideoConferenceDurationEvents(
///     onUpdated: (Duration duration) {
///       // handle duration update
///     },
///   ),
/// )
/// ```
class ZegoUIKitPrebuiltVideoConferenceEvents {
  /// Events about duration, such as conference duration updates.
  ZegoVideoConferenceDurationEvents duration;

  /// Constructs the video conference events handler.
  ///
  /// [duration] - Duration-related events callback configuration.
  ZegoUIKitPrebuiltVideoConferenceEvents({
    ZegoVideoConferenceDurationEvents? duration,
  }) : duration = duration ?? ZegoVideoConferenceDurationEvents();
}

/// Duration-related events for video conference timing.
class ZegoVideoConferenceDurationEvents {
  /// Constructs the duration events handler.
  ///
  /// [onUpdated] - Callback function that is called every second during the conference.
  /// Use this to monitor or handle conference duration, such as auto-leave after a set time.
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
  /// [duration] - The current duration of the conference.
  void Function(Duration)? onUpdated;
}
