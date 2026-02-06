# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

ZegoUIKitPrebuiltVideoConference is a Flutter plugin for building real-time video conference applications. It provides a prebuilt, customizable UI for group voice/video calls with screen sharing, chat, and member management.

**Main Entry Point:** `lib/zego_uikit_prebuilt_video_conference.dart`
**Primary Widget:** `ZegoUIKitPrebuiltVideoConference` in `lib/src/video_conference.dart`

## Development Commands

```bash
# Install dependencies
flutter pub get

# Run Dart analysis/linting
flutter analyze

# Sort import statements (required before commits)
flutter pub run import_sorter:main

# Run tests
flutter test

# Build example app
cd example && flutter build apk --debug  # Android
cd example && flutter build ios --debug   # iOS
```

## Architecture

### Core Patterns

- **Widget-based UI**: `ZegoUIKitPrebuiltVideoConference` is a `StatefulWidget` that manages the conference UI
- **Singleton Controller**: `ZegoUIKitPrebuiltVideoConferenceController.instance` provides programmatic control
- **Mixins for separation**: Controller logic is split into Dart mixins (`room.dart`, `screen.dart`, `log.dart`, `private/`)
- **Composition**: UI built from reusable components (`top_menu_bar.dart`, `bottom_menu_bar.dart`, `audio_video_view_foreground.dart`)

### Directory Structure

```
lib/src/
├── components/         # Reusable UI widgets (menu bars, member list, chat)
├── config.dart         # Configuration classes (ZegoUIKitPrebuiltVideoConferenceConfig)
├── controller/         # Controller implementations with mixins
├── core/               # Core functionality (live_duration_manager.dart)
├── defines.dart        # Type definitions
├── events.dart         # Event callback classes
├── inner_text.dart     # Localized strings
├── internal/           # Internal utilities (reporter.dart)
└── video_conference.dart  # Main widget
```

### Configuration Flow

1. User creates `ZegoUIKitPrebuiltVideoConferenceConfig` with desired settings
2. Config is passed to `ZegoUIKitPrebuiltVideoConference` widget
3. Controller reads config and applies to UI components
4. UI components use `ValueNotifier` for reactive updates (bar visibility, chat visibility)

## Key APIs

**Main Widget Parameters:**
- `appID`, `appSign`, `userID`, `userName`, `conferenceID` - Required auth params
- `config` - `ZegoUIKitPrebuiltVideoConferenceConfig` for customization
- `events` - `ZegoUIKitPrebuiltVideoConferenceEvents` for callbacks

**Config Options:**
- `topMenuBarConfig`, `bottomMenuBarConfig` - Menu bar behavior
- `avatarBuilder` - Custom user avatar rendering
- `memberListConfig`, `chatViewConfig` - Feature-specific settings
- `video`, `audioVideoViewConfig` - Video/audio configuration

## Important Notes

- The controller uses `part of` declarations to split implementation across files
- Always run `import_sorter:main` after modifying imports before committing
- Public members require documentation comments (enforced by `public_member_api_docs` lint)
- The plugin depends on `zego_uikit: ^3.0.0` for core functionality
