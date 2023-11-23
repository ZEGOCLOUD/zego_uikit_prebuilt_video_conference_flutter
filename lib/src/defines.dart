/// Predefined buttons that can be added to the top or bottom toolbar.
/// By configuring these options, users can customize their own top menu bar or bottom toolbar.
/// This enum type is used in ZegoUIKitPrebuiltVideoConferenceConfig.bottomMenuBarConfig and ZegoUIKitPrebuiltVideoConferenceConfig.topMenuBarConfig.
enum ZegoMenuBarButtonName {
  /// Button for controlling the camera switch.
  toggleCameraButton,

  /// Button for controlling the microphone switch.
  toggleMicrophoneButton,

  /// Button for leaving the current meeting.
  leaveButton,

  /// Button for switching between front and rear cameras.
  switchCameraButton,

  /// Button for switching audio output.
  /// You can switch to the speaker, or to Bluetooth, headphones, and earbuds.
  switchAudioOutputButton,

  /// Button for controlling the visibility of the member list.
  showMemberListButton,

  /// Button to open/hide the chat UI.
  chatButton,

  /// Button for toggling screen sharing.
  toggleScreenSharingButton,
}

/// the style of sound waves
enum SoundWaveType {
  none,

  /// display sound wave animation around the avatar according to volume
  aroundAvatar,
}
