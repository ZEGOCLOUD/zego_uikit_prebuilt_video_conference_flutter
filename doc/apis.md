# API Reference

- [ZegoUIKitPrebuiltVideoConferenceController](#zegouikitprebuiltvideoconferencecontroller)
    - [ZegoVideoConferenceRoomController](#zegovideoconferenceroomcontroller)
        - [leave](#leave)
        - [removeUser](#removeuser)
        - [muteUser](#muteuser)
    - [ZegoVideoConferenceScreenController](#zegovideoconferencescreencontroller)
        - [showScreenSharingViewInFullscreenMode](#showscreensharingviewinfullscreenmode)
        - [screenSharingViewController](#screensharingviewcontroller)
    - [ZegoVideoConferenceRoomControllerLog](#zegovideoconferenceroomcontrollerlog)
        - [exportLogs](#exportlogs)

---

## ZegoUIKitPrebuiltVideoConferenceController

`ZegoUIKitPrebuiltVideoConferenceController` is a singleton class that manages the video conference state and operations. It uses mixins to organize functionalities into different categories.

```dart
class ZegoUIKitPrebuiltVideoConferenceController
    with
        ZegoVideoConferenceControllerPrivate,
        ZegoVideoConferenceControllerRoom,
        ZegoVideoConferenceRoomControllerLog,
        ZegoVideoConferenceControllerScreen {
  factory ZegoUIKitPrebuiltVideoConferenceController() => instance;

  static final ZegoUIKitPrebuiltVideoConferenceController instance =
      ZegoUIKitPrebuiltVideoConferenceController._internal();

  String get version => "3.0.0";
}
```

---

## ZegoVideoConferenceRoomController

This mixin provides methods for room management. Access via `ZegoUIKitPrebuiltVideoConferenceController().room`.

### leave

- **Description**
  Leave the video conference.

- **Prototype**
  ```dart
  Future<bool> leave(
    BuildContext context, {
    bool showConfirmation = true,
  })
  ```

- **Example**
  ```dart
  ZegoUIKitPrebuiltVideoConferenceController().room.leave(context);
  ```

---

### removeUser

- **Description**
  Remove user from conference, kick out. Returns an error code, please refer to the [error codes document](https://docs.zegocloud.com/en/5548.html) for details.

- **Prototype**
  ```dart
  Future<bool> removeUser(List<String> userIDs)
  ```

- **Example**
  ```dart
  // Remove specific users from the conference
  ZegoUIKitPrebuiltVideoConferenceController().room.removeUser(['user_id_1', 'user_id_2']);
  ```

---

### muteUser

- **Description**
  Turn on/off user's microphone. If you want to activate the other user's microphone, due to privacy permissions, please pay attention to `ZegoUIKitPrebuiltVideoConferenceConfig.onMicrophoneTurnOnByOthersConfirmation`.

- **Prototype**
  ```dart
  Future<void> muteUser(bool mute, List<String> userIDs)
  ```

- **Example**
  ```dart
  // Mute specific users' microphones
  ZegoUIKitPrebuiltVideoConferenceController().room.muteUser(true, ['user_id_1']);

  // Unmute specific users' microphones
  ZegoUIKitPrebuiltVideoConferenceController().room.muteUser(false, ['user_id_1']);
  ```

---

## ZegoVideoConferenceScreenController

This mixin provides methods for screen sharing. Access via `ZegoUIKitPrebuiltVideoConferenceController().screen`.

### showScreenSharingViewInFullscreenMode

- **Description**
  This function is used to specify whether a certain user enters or exits full-screen mode during screen sharing.

- **Prototype**
  ```dart
  void showScreenSharingViewInFullscreenMode(String userID, bool isFullscreen)
  ```

- **Example**
  ```dart
  // Enter full-screen mode for screen sharing
  ZegoUIKitPrebuiltVideoConferenceController().screen.showScreenSharingViewInFullscreenMode('user_id', true);

  // Exit full-screen mode
  ZegoUIKitPrebuiltVideoConferenceController().screen.showScreenSharingViewInFullscreenMode('user_id', false);
  ```

---

### screenSharingViewController

- **Description**
  Provides access to the screen sharing view controller for additional control options.

- **Prototype**
  ```dart
  ZegoScreenSharingViewController get screenSharingViewController
  ```

---

## ZegoVideoConferenceRoomControllerLog

This mixin provides methods for log management. Access via `ZegoUIKitPrebuiltVideoConferenceController().log`.

### exportLogs

- **Description**
  Export logs for debugging purposes.

- **Prototype**
  ```dart
  Future<bool> exportLogs({
    String? title,
    String? content,
    String? fileName,
    List<ZegoLogExporterFileType> fileTypes = const [
      ZegoLogExporterFileType.txt,
      ZegoLogExporterFileType.log,
      ZegoLogExporterFileType.zip
    ],
    List<ZegoLogExporterDirectoryType> directories = const [
      ZegoLogExporterDirectoryType.zegoUIKits,
      ZegoLogExporterDirectoryType.zimAudioLog,
      ZegoLogExporterDirectoryType.zimLogs,
      ZegoLogExporterDirectoryType.zefLogs,
      ZegoLogExporterDirectoryType.zegoLogs,
    ],
    void Function(double progress)? onProgress,
  })
  ```

- **Example**
  ```dart
  // Export all logs with default settings
  ZegoUIKitPrebuiltVideoConferenceController().log.exportLogs();

  // Export logs with custom title and progress callback
  ZegoUIKitPrebuiltVideoConferenceController().log.exportLogs(
    title: 'debug_logs',
    content: 'User reported an issue',
    onProgress: (progress) {
      print('Export progress: ${(progress * 100).toInt()}%');
    },
  );
  ```
