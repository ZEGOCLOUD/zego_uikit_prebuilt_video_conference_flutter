# Components

- [ZegoUIKitPrebuiltVideoConference](#zegouikitprebuiltvideoconference)

---

## ZegoUIKitPrebuiltVideoConference

> [ZegoUIKitPrebuiltVideoConference](https://pub.dev/documentation/zego_uikit_prebuilt_video_conference/latest/zego_uikit_prebuilt_video_conference/ZegoUIKitPrebuiltVideoConference-class.html)

Video Conference Widget.

You can embed this widget into any page of your project to integrate the functionality of a video conference.

| Name | Description | Type | Default Value |
| :--- | :--- | :--- | :--- |
| **appID** | App ID, you can get it from the [ZEGOCLOUD Admin Console](https://console.zegocloud.com). | `int` | |
| **appSign** | App Sign, you can get it from the [ZEGOCLOUD Admin Console](https://console.zegocloud.com). | `String` | |
| **userID** | The ID of the currently logged-in user. It can be any valid string. Typically, you would use the ID from your own user system. | `String` | |
| **userName** | The name of the currently logged-in user. It can be any valid string. Typically, you would use the name from your own user system. | `String` | |
| **conferenceID** | The ID of the conference. Users who use the same conferenceID can talk with each other. | `String` | |
| **config** | Configuration for initializing the video conference. See [ZegoUIKitPrebuiltVideoConferenceConfig](configs.md#zegouikitprebuiltvideoconferenceconfig). | `ZegoUIKitPrebuiltVideoConferenceConfig` | |
| **events** | Events for the video conference. See [ZegoUIKitPrebuiltVideoConferenceEvents](events.md#zegouikitprebuiltvideoconferenceevents). | `ZegoUIKitPrebuiltVideoConferenceEvents?` | `null` |
| **controller** | **Deprecated since 2.9.1** Use `ZegoUIKitPrebuiltVideoConferenceController()` instead. | `ZegoUIKitPrebuiltVideoConferenceController?` | `null` |
