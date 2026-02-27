# Configuration

- [ZegoUIKitPrebuiltVideoConferenceConfig](#zegouikitprebuiltvideoconferenceconfig)
    - [ZegoPrebuiltAudioVideoViewConfig](#zegoprebuiltaudiovideoviewconfig)
    - [ZegoMenuBarStyle](#zegomenubarstyle)
    - [ZegoTopMenuBarConfig](#zegotopmenubarconfig)
    - [ZegoBottomMenuBarConfig](#zegobottommenubarconfig)
    - [ZegoMemberListConfig](#zegomemberlistconfig)
    - [ZegoLeaveConfirmDialogInfo](#zegoleaveconfirmdialoginfo)
    - [ZegoInRoomNotificationViewConfig](#zegoinroomnotificationviewconfig)
    - [ZegoInRoomChatViewConfig](#zegoinroomchatviewconfig)
    - [ZegoVideoConferenceDurationConfig](#zegovideoconferencedurationconfig)
    - [ZegoUIKitPrebuiltLiveVideoConferenceInnerText](#zegouikitprebuiltlivevideoconferenceinnertext)

---

## ZegoUIKitPrebuiltVideoConferenceConfig

Configuration for initializing the Video Conference. This class is used as the `config` parameter for the constructor of [ZegoUIKitPrebuiltVideoConference](components.md#zegouikitprebuiltvideoconference).

- **Properties**

| Name | Description | Type | Default Value |
| :--- | :--- | :--- | :--- |
| **turnOnCameraWhenJoining** | Whether to open the camera when joining the video conference. If you want to join with your camera closed, set this to false. | `bool` | `true` |
| **useFrontFacingCamera** | If you want to join the video conference with your front camera, set this value to true. | `bool` | `true` |
| **turnOnMicrophoneWhenJoining** | Whether to open the microphone when joining the video conference. If you want to join with your microphone closed, set this to false. | `bool` | `true` |
| **useSpeakerWhenJoining** | Whether to use the speaker to play audio when joining the video conference. If set to false, the system's default playback device will be used. | `bool` | `true` |
| **rootNavigator** | Same as Flutter's Navigator's param. If `rootNavigator` is set to true, the state from the furthest instance of this class is given instead. | `bool` | `false` |
| **video** | Configuration parameters for audio and video streaming, such as Resolution, Frame rate, Bit rate. | `ZegoUIKitVideoConfig` | `ZegoVideoConfigExtension.preset360P()` |
| **audioVideoViewConfig** | Configuration options for audio/video views. See [ZegoPrebuiltAudioVideoViewConfig](#zegoprebuiltaudiovideoviewconfig). | `ZegoPrebuiltAudioVideoViewConfig` | |
| **topMenuBarConfig** | Configuration options for the top menu bar. See [ZegoTopMenuBarConfig](#zegotopmenubarconfig). | `ZegoTopMenuBarConfig` | |
| **bottomMenuBarConfig** | Configuration options for the bottom menu bar. See [ZegoBottomMenuBarConfig](#zegobottommenubarconfig). | `ZegoBottomMenuBarConfig` | |
| **memberListConfig** | Configuration related to the member list. See [ZegoMemberListConfig](#zegomemberlistconfig). | `ZegoMemberListConfig` | |
| **notificationViewConfig** | Configuration related to the notification message list. See [ZegoInRoomNotificationViewConfig](#zegoinroomnotificationviewconfig). | `ZegoInRoomNotificationViewConfig` | |
| **chatViewConfig** | Configuration related to the chat view. See [ZegoInRoomChatViewConfig](#zegoinroomchatviewconfig). | `ZegoInRoomChatViewConfig` | |
| **duration** | Video Conference timing configuration. See [ZegoVideoConferenceDurationConfig](#zegovideoconferencedurationconfig). | `ZegoVideoConferenceDurationConfig` | |
| **innerText** | Configuration options for modifying all text content on the UI. See [ZegoUIKitPrebuiltLiveVideoConferenceInnerText](#zegouikitprebuiltlivevideoconferenceinnertext). | `ZegoUIKitPrebuiltLiveVideoConferenceInnerText` | |
| **layout** | Layout-related configuration. You can choose your layout here. | `ZegoLayout?` | `ZegoLayout.gallery()` |
| **avatarBuilder** | Use this to customize the avatar, and replace the default avatar with it. | `ZegoAvatarBuilder?` | `null` |
| **foreground** | The foreground of the video conference. | `Widget?` | `null` |
| **background** | The background of the video conference. You can use any Widget as the background. | `Widget?` | `null` |
| **leaveConfirmDialogInfo** | Confirmation dialog information when leaving the video conference. See [ZegoLeaveConfirmDialogInfo](#zegoleaveconfirmdialoginfo). | `ZegoLeaveConfirmDialogInfo?` | `null` |
| **onLeaveConfirmation** | Confirmation callback method before leaving the video conference. Returns whether the user can leave. | `Future<bool?> Function(BuildContext context)?` | `null` |
| **onLeave** | This callback is triggered after leaving the video conference. | `VoidCallback?` | `null` |
| **onMeRemovedFromRoom** | This callback is triggered when local user is removed from the video conference. | `Future<void> Function(String)?` | `null` |
| **onCameraTurnOnByOthersConfirmation** | This callback method is called when someone requests to open your camera. Returns whether to allow. | `Future<bool> Function(BuildContext context)?` | `null` |
| **onMicrophoneTurnOnByOthersConfirmation** | This callback method is called when someone requests to open your microphone. Returns whether to allow. | `Future<bool> Function(BuildContext context)?` | `null` |
| **onError** | Error stream callback. | `Function(ZegoUIKitError)?` | `null` |

---

## ZegoPrebuiltAudioVideoViewConfig

Configuration options for audio/video views. These options allow you to customize the display effects of the audio/video views.

- **Properties**

| Name | Description | Type | Default Value |
| :--- | :--- | :--- | :--- |
| **visible** | Show target user's audio video view or not. Return false if you don't want to show target user's view. | `bool Function(ZegoUIKitUser localUser, ZegoUIKitUser targetUser)?` | `null` |
| **muteInvisible** | True: not play audio if invisible; False: Although invisible, audio is also played. | `bool` | `true` |
| **isVideoMirror** | Whether to mirror the displayed video captured by the camera. This mirroring effect only applies to the front-facing camera. | `bool` | `true` |
| **showMicrophoneStateOnView** | Whether to display the microphone status on the audio/video view. | `bool` | `true` |
| **showCameraStateOnView** | Whether to display the camera status on the audio/video view. | `bool` | `false` |
| **showUserNameOnView** | Whether to display the username on the audio/video view. | `bool` | `true` |
| **foregroundBuilder** | You can customize the foreground of the audio/video view. | `ZegoAudioVideoViewForegroundBuilder?` | `null` |
| **backgroundBuilder** | Background for the audio/video windows in a Video Conference. | `ZegoAudioVideoViewBackgroundBuilder?` | `null` |
| **useVideoViewAspectFill** | Video view mode. Set to true if you want the video view to scale proportionally to fill the entire view. | `bool` | `false` |
| **showAvatarInAudioMode** | Whether to display user avatars in audio mode. | `bool` | `true` |
| **showSoundWavesInAudioMode** | Whether to display sound waveforms in audio mode. | `bool` | `true` |

---

## ZegoMenuBarStyle

This enum consists of two style options: light and dark. The light style represents a light theme with a transparent background, while the dark style represents a dark theme with a black background.

- **Enum Values**

| Name | Description | Value |
| :--- | :--- | :--- |
| **light** | Light theme with transparent background. | `0` |
| **dark** | Dark theme with black background. | `1` |

---

## ZegoTopMenuBarConfig

Configuration options for the top menu bar (toolbar). You can use the `ZegoUIKitPrebuiltVideoConferenceConfig.topMenuBarConfig` property to set these options.

- **Properties**

| Name | Description | Type | Default Value |
| :--- | :--- | :--- | :--- |
| **isVisible** | Whether to display the top menu bar. | `bool` | `true` |
| **title** | Title of the top menu bar. | `String` | `'Conference'` |
| **hideAutomatically** | Whether to automatically collapse the top menu bar after 5 seconds of inactivity. | `bool` | `true` |
| **hideByClick** | Whether to collapse the top menu bar when clicking on the blank area. | `bool` | `true` |
| **buttons** | Buttons displayed on the menu bar. The buttons will be arranged in the order specified in the list. | `List<ZegoMenuBarButtonName>` | `[showMemberListButton, switchCameraButton, toggleScreenSharingButton]` |
| **style** | Style of the top menu bar. See [ZegoMenuBarStyle](#zegomenubarstyle). | `ZegoMenuBarStyle` | `ZegoMenuBarStyle.dark` |
| **extendButtons** | Extension buttons that allow you to add your own buttons to the top toolbar. | `List<Widget>` | `[]` |
| **padding** | Padding for the top menu bar. | `EdgeInsetsGeometry?` | `null` |
| **margin** | Margin for the top menu bar. | `EdgeInsetsGeometry?` | `null` |
| **backgroundColor** | Background color for the top menu bar. | `Color?` | `null` |
| **height** | Height for the top menu bar. | `double?` | `null` |

---

## ZegoBottomMenuBarConfig

Configuration options for the bottom menu bar (toolbar). You can use the `ZegoUIKitPrebuiltVideoConferenceConfig.bottomMenuBarConfig` property to set these options.

- **Properties**

| Name | Description | Type | Default Value |
| :--- | :--- | :--- | :--- |
| **hideAutomatically** | If true, menu bars will collapse after stand still for 5 seconds. | `bool` | `true` |
| **hideByClick** | If true, menu bars will collapse when clicks on blank spaces. | `bool` | `true` |
| **buttons** | These buttons will displayed on the menu bar, order by the list. | `List<ZegoMenuBarButtonName>` | `[toggleCameraButton, toggleMicrophoneButton, leaveButton, switchAudioOutputButton, chatButton]` |
| **maxCount** | Controls the maximum number of buttons to be displayed in the menu bar. When exceeded, a "More" button will appear. | `int` | `5` |
| **style** | Button style for the bottom menu bar. See [ZegoMenuBarStyle](#zegomenubarstyle). | `ZegoMenuBarStyle` | `ZegoMenuBarStyle.dark` |
| **backgroundColor** | Background color of the bottom menu bar. | `Color?` | `null` |
| **extendButtons** | Extension buttons that allow you to add your own buttons to the bottom toolbar. | `List<Widget>` | `[]` |

---

## ZegoMemberListConfig

Configuration for the member list. You can use the `ZegoUIKitPrebuiltVideoConferenceConfig.memberListConfig` property to set these options.

- **Properties**

| Name | Description | Type | Default Value |
| :--- | :--- | :--- | :--- |
| **showMicrophoneState** | Whether to show the microphone state of the member. Defaults to true. | `bool` | `true` |
| **showCameraState** | Whether to show the camera state of the member. Defaults to true. | `bool` | `true` |
| **itemBuilder** | Custom member list item view. | `ZegoMemberListItemBuilder?` | `null` |

---

## ZegoLeaveConfirmDialogInfo

Configuration for the leave confirmation dialog. You can use the `ZegoUIKitPrebuiltVideoConferenceConfig.leaveConfirmDialogInfo` property to set these options.

- **Properties**

| Name | Description | Type | Default Value |
| :--- | :--- | :--- | :--- |
| **title** | The title of the dialog. | `String` | `'Leave the conference'` |
| **message** | The message content of the dialog. | `String` | `'Are you sure to leave the conference?'` |
| **cancelButtonName** | The text for the cancel button. | `String` | `'Cancel'` |
| **confirmButtonName** | The text for the confirm button. | `String` | `'OK'` |

---

## ZegoInRoomNotificationViewConfig

Configuration for the in-room notification view. You can use the `ZegoUIKitPrebuiltVideoConferenceConfig.notificationViewConfig` property to set these options.

- **Properties**

| Name | Description | Type | Default Value |
| :--- | :--- | :--- | :--- |
| **notifyUserLeave** | Set this to true if you want to be notified when a user leaves the room. | `bool` | `true` |
| **itemBuilder** | The builder for customizing the notification message item. | `ZegoNotificationMessageItemBuilder?` | `null` |
| **userJoinItemBuilder** | The builder for customizing the user join item. | `ZegoNotificationUserItemBuilder?` | `null` |
| **userLeaveItemBuilder** | The builder for customizing the user leave item. | `ZegoNotificationUserItemBuilder?` | `null` |

---

## ZegoInRoomChatViewConfig

Control options for the chat view. You can use the `ZegoUIKitPrebuiltVideoConferenceConfig.chatViewConfig` property to set these options.

- **Properties**

| Name | Description | Type | Default Value |
| :--- | :--- | :--- | :--- |
| **itemBuilder** | Use this to customize the style and content of each chat message list item. | `ZegoInRoomMessageItemBuilder?` | `null` |

---

## ZegoVideoConferenceDurationConfig

Timing configuration for the video conference.

- **Properties**

| Name | Description | Type | Default Value |
| :--- | :--- | :--- | :--- |
| **isVisible** | Whether to display video conference timing. | `bool` | `true` |
| **canSync** | Whether the current user can synchronize duration. If true, the duration will be resynchronized when user joins; if false, the user will read the duration. | `bool` | `false` |

---

## ZegoUIKitPrebuiltLiveVideoConferenceInnerText

Control the text on the UI. Modify the values of the corresponding properties to modify the text on the UI. You can also change it to other languages.

- **Properties**

| Name | Description | Type | Default Value |
| :--- | :--- | :--- | :--- |
| **param_1** | %0 is a string placeholder, represents the first parameter of prompt. | `String` | `'%0'` |
| **screenSharingTipText** | When sharing the screen, the text prompt on the sharing side. | `String` | `'You are sharing screen'` |
| **stopScreenSharingButtonText** | When screen sharing, stop sharing button text on the sharing side. | `String` | `'Stop sharing'` |
