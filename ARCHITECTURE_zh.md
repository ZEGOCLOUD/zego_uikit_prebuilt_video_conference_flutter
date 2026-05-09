# ZegoUIKitPrebuiltVideoConference Architecture

> 视频会议 SDK，多人视频通话场景

## Overview

`zego_uikit_prebuilt_video_conference_flutter` 是**视频会议预构建 UI SDK**：

- **多方视频通话**: 支持多人同时视频会议
- **成员管理**: 加入/离开、成员列表
- **布局切换**: Grid/PiP 等多种布局
- **实时聊天**: 房间内文字消息

**依赖**: `zego_uikit_flutter` (核心SDK)

## Package Relationship

```mermaid
graph TB
    UI["zego_uikit_flutter<br/>(Core SDK)"]
    PA["zego_plugin_adapter_flutter"]
    VC["zego_uikit_prebuilt_video_conference_flutter"]

    VC --> UI
```

## Core Pattern: Equal Participants

视频会议中所有参与者地位平等，没有 Call SDK 中的主持人概念：

```
ZegoUIKitPrebuiltVideoConference
       │
       ├── 所有用户可平等加入/离开
       ├── 所有用户可开关自己的音视频
       └── 没有主持人特殊权限
```

## Quick Start

```dart
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

class ConferencePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltVideoConference(
      appID: yourAppID,
      appSign: yourAppSign,
      conferenceID: 'conference_001',  // 会议ID
      userID: currentUserID,
      userName: currentUserName,
      config: ZegoUIKitPrebuiltVideoConferenceConfig()
        ..turnOnCameraWhenJoining = true
        ..turnOnMicrophoneWhenJoining = false
        ..bottomMenuBarConfig(
          buttons: [
            ZegoVideoConferenceMenuBarButtonName.toggleMicrophone,
            ZegoVideoConferenceMenuBarButtonName.toggleCamera,
            ZegoVideoConferenceMenuBarButtonName.switchCamera,
            ZegoVideoConferenceMenuBarButtonName.hangUp,
          ],
        ),
      events: ZegoUIKitPrebuiltVideoConferenceEvents(
        onConferenceEnd: (reason) {
          Navigator.pop(context);
        },
      ),
    );
  }
}
```

## Configuration Pattern

```dart
ZegoUIKitPrebuiltVideoConferenceConfig config = ZegoUIKitPrebuiltVideoConferenceConfig()
  // 入会时设备状态
  ..turnOnCameraWhenJoining = true
  ..turnOnMicrophoneWhenJoining = false
  ..useFrontCameraWhenJoining = true

  // 顶部菜单栏
  ..topMenuBarConfig(
    title: 'Video Conference',
    showUserInviteButton: true,
    showCloseButton: true,
  )

  // 底部菜单栏
  ..bottomMenuBarConfig(
    buttons: [
      ZegoVideoConferenceMenuBarButtonName.toggleMicrophone,
      ZegoVideoConferenceMenuBarButtonName.toggleCamera,
      ZegoVideoConferenceMenuBarButtonName.switchCamera,
      ZegoVideoConferenceMenuBarButtonName.memberList,
      ZegoVideoConferenceMenuBarButtonName.chat,
      ZegoVideoConferenceMenuBarButtonName.hangUp,
    ],
  )

  // 成员列表
  ..memberListConfig(
    showMicrophoneState: true,
    showCameraState: true,
  )

  // 聊天视图
  ..chatViewConfig(
    showInCallMessage: true,
  )

  // 头像
  ..avatarBuilder = (context, size, user, extraInfo) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
        image: DecorationImage(
          image: NetworkImage('https://api.example.com/avatar/${user.id}'),
        ),
      ),
    );
  };
```

### 视频配置

```dart
// 配置视频质量
..videoConfig = ZegoUIKitVideoConfig.preset720p()

// 或自定义
..videoConfig = ZegoUIKitVideoConfig(
  resolution: ZegoVideoResolution(1280, 720),
  frameRate: 30,
  bitrate: 3000,
)
```

## Controller API

```dart
final controller = ZegoUIKitPrebuiltVideoConferenceController();

// 离开会议
await controller.leave();

// 音视频控制
controller.audioVideo.muteMicrophone(true);
controller.audioVideo.muteCamera(true);
controller.audioVideo.toggleCamera();
controller.audioVideo.switchCamera();

// 用户管理
final users = controller.user.getAllUsers();
final speakers = controller.user.getSpeakers();

// 消息
controller.message.send('Hello everyone!');
```

### Controller Mixins

| Mixin | 说明 |
|-------|------|
| `ZegoVideoConferenceControllerAudioVideo` | 音视频控制 |
| `ZegoVideoConferenceControllerRoom` | 房间操作 |
| `ZegoVideoConferenceControllerUser` | 用户管理 |
| `ZegoVideoConferenceControllerMessage` | 消息 |
| `ZegoVideoConferenceControllerMedia` | 媒体控制 |
| `ZegoVideoConferenceControllerScreenSharing` | 屏幕共享 |

## Events

```dart
ZegoUIKitPrebuiltVideoConferenceEvents(
  // 用户事件
  onUserJoin: (user) {
    print('${user.name} joined');
  },
  onUserLeave: (user) {
    print('${user.name} left');
  },

  // 设备状态变化
  onUserCameraTurnOn: (user) {
    print('${user.name} turned on camera');
  },
  onUserCameraTurnOff: (user) {
    print('${user.name} turned off camera');
  },
  onUserMicrophoneTurnOn: (user) {
    print('${user.name} turned on microphone');
  },
  onUserMicrophoneTurnOff: (user) {
    print('${user.name} turned off microphone');
  },

  // 消息
  onReceiveChatMessage: (fromUser, message) {
    print('${fromUser.name}: $message');
  },

  // 会议结束
  onConferenceEnd: (reason) {
    print('Conference ended: $reason');
    Navigator.pop(context);
  },

  // 错误
  onError: (errorCode, errorMessage) {
    print('Error: $errorCode - $errorMessage');
  },

  // 屏幕共享
  onScreenSharingStarted: (user) {},
  onScreenSharingStopped: (user) {},
)
```

## Layout Modes

### Grid Layout (默认)

所有参与者以网格形式展示，适合小规模会议：

```dart
..layoutConfig = ZegoVideoConferenceLayoutConfig(
  mode: ZegoVideoConferenceLayoutMode.grid,
  maxDisplayCount: 9,  // 最多显示9个视频
)
```

### Gallery Layout

自动调整网格大小：

```
4人: 2x2    9人: 3x3    16人: 4x4
```

### Speaker Mode

突出显示当前发言者，其他人在小窗中：

```dart
..layoutConfig = ZegoVideoConferenceLayoutConfig(
  mode: ZegoVideoConferenceLayoutMode.speaker,
)
```

## Directory Structure

```
lib/src/
├── video_conference.dart       # 主入口 Widget
├── controller.dart            # Controller 单例
├── config.dart               # ZegoUIKitPrebuiltVideoConferenceConfig
├── events.dart               # Events
├── defines.dart
├── inner_text.dart
├── components/              # UI 组件
│   ├── components.dart
│   ├── top_bar.dart
│   ├── bottom_bar.dart
│   ├── member/
│   │   ├── member_list.dart
│   │   └── member_list_item.dart
│   ├── message/
│   │   ├── chat_view.dart
│   │   └── message_item.dart
│   ├── duration_time_board.dart
│   ├── pop_up_manager.dart
│   └── audio_video_view_foreground.dart
├── controller/              # Controller mixins
│   ├── audio_video.dart
│   ├── room.dart
│   ├── user.dart
│   ├── message.dart
│   ├── media.dart
│   ├── screen_sharing.dart
│   └── private/
├── core/                    # 核心管理器
│   └── live_duration_manager.dart
├── internal/
└── build/
```

## Key Differences from Call SDK

| Aspect | Video Conference | Call SDK |
|--------|-----------------|----------|
| Use Case | Meeting, collaboration | 1v1/group calls |
| Role Model | 平等参与者 | Host/participant roles |
| Layout | Grid with member list | Full-featured call UI |
| Invite | No built-in invite | Call invitation system |
| Duration | No auto-end timer | Has duration timer |

## Comparison with Other Prebuilt SDKs

| Feature | Call | Live Streaming | Audio Room | Video Conference |
|---------|------|----------------|------------|------------------|
| Video | ✓ | ✓ | ✗ | ✓ |
| Audio Only Mode | ✓ | ✓ | ✓ | ✓ |
| Role Model | Host/Participant | Host/Co-host/Audience | Host/Speaker/Listener | Equal |
| Invite System | ✓ | ✗ | ✗ | ✗ |
| PK | ✗ | ✓ | ✗ | ✗ |
| Seat/Stage | ✗ | ✗ | ✓ | ✗ |
| Swiping | ✗ | ✓ | ✗ | ✗ |

## Dependency Packages

核心依赖：
- `zego_uikit` - 核心 SDK
- `zego_plugin_adapter` - 插件适配
- `permission_handler` - 权限管理

## Related Documentation

- [ZegoUIKit Architecture](../zego_uikit_flutter/ARCHITECTURE.md)
- [ZegoUIKitPrebuiltCall Architecture](../zego_uikit_prebuilt_call_flutter/ARCHITECTURE.md)
- [ZegoUIKitPrebuiltLiveStreaming Architecture](../zego_uikit_prebuilt_live_streaming_flutter/ARCHITECTURE.md)