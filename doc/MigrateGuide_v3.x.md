> This document aims to help users understand the APIs changes and feature improvements, and provide a migration guide for the upgrade process.
>
> It is an `incompatible change` if marked with `breaking changes`.
> You can run this command in `the root directory of your project` to output warnings and partial error prompts to assist you in finding deprecated parameters/functions or errors after upgrading.
> 
> ```shell
> dart analyze | grep zego
> ```
>
> 
> Versions
> - 3.0.0  (💥 breaking changes)
>
> 
> # 3.0.0
> ---
>
> # Introduction
>
> 3.0 aligns with `zego_uikit 3.0`. Some configuration types were unified and controller/event behaviors were streamlined for consistency across UIKits.
>
> # Major Interface Changes
>
> - Dependencies
>   - require `zego_uikit: ^3.0.0`
>
> - Config updates
>   - `video`: new property using `ZegoUIKitVideoConfig` to replace scattered video parameters
>   - `audioVideoView`: type changed from `ZegoPrebuiltAudioVideoViewConfig` to `ZegoVideoConferenceAudioVideoViewConfig`
>   - `topMenuBar`: type changed from `ZegoTopMenuBarConfig` to `ZegoVideoConferenceTopMenuBarConfig`
>   - `bottomMenuBar`: type changed from `ZegoBottomMenuBarConfig` to `ZegoVideoConferenceBottomMenuBarConfig`
>   - `memberList`: type changed from `ZegoMemberListConfig` to `ZegoVideoConferenceMemberListConfig`
>   - `chat`: type changed from `ZegoInRoomChatConfig` to `ZegoVideoConferenceChatConfig`
>   - `audioEffect`: type changed from `ZegoAudioEffectConfig` to `ZegoVideoConferenceAudioEffectConfig`
>   - `duration`: type changed from `ZegoLiveDurationConfig` to `ZegoVideoConferenceDurationConfig`
>
> - Events and callbacks
>   - Leave/hang-up flows use `onLeaveConfirmation`, `onLeave`, `onMeRemovedFromRoom`
>   - Audio/video device events are exposed through toolkit-level events
>
> ### Migration Guide
>
> 2.x Version Code:
> ```dart
> final config = ZegoUIKitPrebuiltVideoConferenceConfig(
>   // scattered video params
> );
> ```
>
> 3.0.0 Version Code:
> ```dart
> final config = ZegoUIKitPrebuiltVideoConferenceConfig(
>   video: ZegoVideoConfigExtension.preset360P(),
>   audioVideoViewConfig: ZegoPrebuiltAudioVideoViewConfig(),
>   duration: ZegoVideoConferenceDurationConfig()
>     ..isVisible = true,
> );
> ```
>
> ### Compatibility Notes
> - Update your dependency to `zego_uikit: ^3.0.0`.
> - If analyzer still reports errors, run:
> ```shell
> dart analyze | grep zego
> ```
>
