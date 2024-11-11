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
  ///
  /// Obtain user screen recording authorization
  ///
  /// Be sure to declare the following permissions or you will not be able to use screen sharing.
  ///
  /// In the AndroidManifest.xml file of the project, add the permission configuration for screen recording.
  /// After setting, before recording the screen, a pop-up window will prompt the user whether to allow the application to record the screen, which requires manual authorization from the user.
  ///
  /// - The screen recording function relies on the front-end service to keep it alive. Go to the "app/src/main" directory of your project, open the "AndroidManifest.xml" file, and add permission declarations.
  ///
  ///   - If the target Android SDK version is below the 34.0.0 version, set FOREGROUND_SERVICE permission claims.
  ///      <uses-permission android:name="android.permission.FOREGROUND_SERVICE"/>
  ///
  ///   - If the target Android SDK version is 34.0.0 or later, you need to set FOREGROUND_SERVICE and FOREGROUND_SERVICE_MEDIA_PROJECTION permission claims.
  ///      <uses-permission android:name="android.permission.FOREGROUND_SERVICE"/>
  ///      <uses-permission android:name="android.permission.FOREGROUND_SERVICE_MEDIA_PROJECTION"/>
  toggleScreenSharingButton,
}

/// the style of sound waves
enum SoundWaveType {
  none,

  /// display sound wave animation around the avatar according to volume
  aroundAvatar,
}
