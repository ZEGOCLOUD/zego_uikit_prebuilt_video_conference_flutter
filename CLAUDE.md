# CLAUDE.md

> **Note**: This library is part of the `zego_uikits` monorepo. See the root [CLAUDE.md](https://github.com/your-org/zego_uikits/blob/main/CLAUDE.md) for cross-library dependencies and architecture overview.

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Workflow Orchestration

### 1. Plan Node Default
- Enter plan mode for ANY non-trivial task (3+ steps or architectural decisions)
- If something goes sideways, STOP and re-plan immediately - don't keep pushing
- Use plan mode for verification steps, not just building
- Write detailed specs upfront to reduce ambiguity

### 2. Subagent Strategy
- Use subagents liberally to keep main context window clean
- Offload research, exploration, and parallel analysis to subagents
- For complex problems, throw more compute at it via subagents
- One tack per subagent for focused execution

### 3. Self-Improvement Loop
- After ANY correction from the user: update `tasks/lessons.md` with the pattern
- Write rules for yourself that prevent the same mistake
- Ruthlessly iterate on these lessons until mistake rate drops
- Review lessons at session start for relevant project

### 4. Verification Before Done
- Never mark a task complete without proving it works
- Diff behavior between main and your changes when relevant
- Ask yourself: "Would a staff engineer approve this?"
- Run tests, check logs, demonstrate correctness

### 5. Demand Elegance (Balanced)
- For non-trivial changes: pause and ask "is there a more elegant way?"
- If a fix feels hacky: "Knowing everything I know now, implement the elegant solution"
- Skip this for simple, obvious fixes - don't over-engineer
- Challenge your own work before presenting it

### 6. Autonomous Bug Fixing
- When given a bug report: just fix it. Don't ask for hand-holding
- Point at logs, errors, failing tests - then resolve them
- Zero context switching required from the user
- Go fix failing CI tests without being told how

## Task Management

1. **Plan First**: Write plan to `tasks/todo.md` with checkable items
2. **Verify Plan**: Check in before starting implementation
3. **Track Progress**: Mark items complete as you go
4. **Explain Changes**: High-level summary at each step
5. **Document Results**: Add review section to `tasks/todo.md`
6. **Capture Lessons**: Update `tasks/lessons.md` after corrections

## Core Principles

- **Simplicity First**: Make every change as simple as possible. Impact minimal code.
- **No Laziness**: Find root causes. No temporary fixes. Senior developer standards.
- **Minimat Impact**: Changes should only touch what's necessary. Avoid introducing bugs.

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
