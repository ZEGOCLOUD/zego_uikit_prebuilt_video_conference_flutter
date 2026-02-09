# Defines

- [ZegoMenuBarButtonName](#zegomenubarbuttonname)
- [SoundWaveType](#soundwavetype)

---

## ZegoMenuBarButtonName

Predefined buttons that can be added to the top or bottom toolbar. By configuring these options, users can customize their own top menu bar or bottom toolbar. This enum type is used in `ZegoUIKitPrebuiltVideoConferenceConfig.bottomMenuBarConfig` and `ZegoUIKitPrebuiltVideoConferenceConfig.topMenuBarConfig`.

- **Enum Values**

| Name | Description | Value |
| :--- | :--- | :--- |
| **toggleCameraButton** | Button for controlling the camera switch. | `0` |
| **toggleMicrophoneButton** | Button for controlling the microphone switch. | `1` |
| **leaveButton** | Button for leaving the current meeting. | `2` |
| **switchCameraButton** | Button for switching between front and rear cameras. | `3` |
| **switchAudioOutputButton** | Button for switching audio output. You can switch to the speaker, or to Bluetooth, headphones, and earbuds. | `4` |
| **showMemberListButton** | Button for controlling the visibility of the member list. | `5` |
| **chatButton** | Button to open/hide the chat UI. | `6` |
| **toggleScreenSharingButton** | Button for toggling screen sharing. | `7` |

---

## SoundWaveType

The style of sound waves displayed around the avatar in audio mode.

- **Enum Values**

| Name | Description | Value |
| :--- | :--- | :--- |
| **none** | No sound wave. | `0` |
| **aroundAvatar** | Display sound wave animation around the avatar according to volume. | `1` |
