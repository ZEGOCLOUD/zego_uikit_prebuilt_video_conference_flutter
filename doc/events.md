# Events

- [ZegoUIKitPrebuiltVideoConferenceEvents](#zegouikitprebuiltvideoconferenceevents)
  - [duration](#zegovideoconferencedurationevents)

---

## ZegoUIKitPrebuiltVideoConferenceEvents

You can listen to events that you are interested in here, such as duration updates.

- **Properties**

| Name | Description | Type | Default Value |
| :--- | :--- | :--- | :--- |
| **duration** | Events about duration. See [ZegoVideoConferenceDurationEvents](#zegovideoconferencedurationevents). | `ZegoVideoConferenceDurationEvents` | `ZegoVideoConferenceDurationEvents()` |

---

## ZegoVideoConferenceDurationEvents

Events about duration in the video conference.

### onUpdated

- **Description**
  Call timing callback function, called every second.

- **Prototype**
  ```dart
  void Function(Duration)? onUpdated;
  ```

- **Example**
  ```dart
  // Set to automatically leave after 5 minutes.
  events = ZegoUIKitPrebuiltVideoConferenceEvents(
    duration: ZegoVideoConferenceDurationEvents(
      onUpdated: (Duration duration) {
        if (duration.inSeconds >= 5 * 60) {
          ZegoUIKitPrebuiltVideoConferenceController().room.leave(context);
        }
      },
    ),
  );
  ```
