## 2.10.1-beta.1

- Features
  - Support horizontal scrolling in top menu bar when buttons overflow
  - Add new configurations in ZegoTopMenuBarConfig:
    - padding: Customize the padding of top menu bar
    - margin: Customize the margin of top menu bar
    - height: Customize the height of top menu bar

## 2.9.9

- Bugs
  - Fix the issue of video rendering failure that affects meetings when other kits use beauty filters

## 2.9.8

- Bugs
  - Fix screen-sharing outside the app, remote pull-based streaming has no sound

## 2.9.7

- Update dependency

## 2.9.6

- Update dependency

## 2.9.5

- Bugs
  - Catch and log crashes in certain scenes

## 2.9.4

- Bugs
  - Fix screen sharing crash issue on android 14

## 2.9.3

- Update dependency

## 2.9.2

- Update dependency

## 2.9.1

- Support **leave** by **ZegoUIKitPrebuiltVideoConferenceController().room**.

## 2.9.0

- Support duration setting, configure whether to display or synchronize time through **ZegoUIKitPrebuiltVideoConferenceConfig.duration**, and listen to callback through 
  **ZegoUIKitPrebuiltVideoConferenceEvents.duration**

## 2.8.5

- Update dependency

## 2.8.4

- Optimization score warning

## 2.8.3

- Update dependency.

## 2.8.2

- Update dependency.

## 2.8.1

- Update dependency.

## 2.8.0

- Features
  - Support **useFrontFacingCamera** in config

## 2.7.4

- Update dependency.

## 2.7.3

- Update dependency.

## 2.7.2

- Update dependency.

## 2.7.1

- Update dependency.

## 2.7.0

- Support for configuration to hide and mute audio & video windows by `ZegoUIKitPrebuiltVideoConferenceConfig.visible` &&`ZegoUIKitPrebuiltVideoConferenceConfig.muteInvisible`.

## 2.6.9

- Update dependency.

## 2.6.8

- Update dependency.

## 2.6.7

- Update dependency.

## 2.6.6

- Fix the issue of video shaking caused by chat input.

## 2.6.5

- Fix the issue where the user window disappears after both the camera and microphone are turned off

## 2.6.4

- Update dependencies

## 2.6.3

- Update dependencies

## 2.6.2

- Optimization warnings from analysis

## 2.6.1

- Optimization warnings from analysis

## 2.6.0

- Support listening for errors signaling plugins and uikit library.

## 2.5.0

- Support remove user and mute user by controller, which can be called through **ZegoUIKitPrebuiltVideoConferenceController.room**.

## 2.4.2

- update dart dependency

## 2.4.1

- remove http library dependency.

## 2.4.0

- The bottom menu bar and top menu bar support custom background colors.

## 2.3.2

- Update ReadME

## 2.3.1

- Update dependencies

## 2.3.0

- Added logic for being kicked out of the video conference, which will automatically exit and return to the previous page.

## 2.2.10

- Fixed an issue where the avatar builder was not working for the member list.

## 2.2.9

- fix the issue of conflict with extension key of the `flutter_screenutil` package.

## 2.2.8

- Update dependencies

## 2.2.7

- Update comments

## 2.2.6

- deprecate flutter_screenutil_zego package

## 2.2.5

- fix import issues

## 2.2.4

- Update dependencies

## 2.2.3

- Fix some issues

## 2.2.2

- mark 'appDesignSize' as Deprecated

## 2.2.1

- Update dependencies

## 2.2.0

- To differentiate the 'appDesignSize' between the App and ZegoUIKitPrebuiltVideoConference, we introduced the 'flutter_screenutil_zego' library and removed the 'appDesignSize' parameter from the
  ZegoUIKitPrebuiltVideoConference that was previously present.

## 2.1.4

- fixed appDesignSize for ScreenUtil that didn't work

## 2.1.3

- add assert to key parameters to ensure prebuilt run normally

## 2.1.2

- fixed landscape not displaying full web screen sharing content

## 2.1.1

- update dependency

## 2.1.0

- support screen share
- update dependency

## 2.0.1

- remove login token
- optimizing code warnings

## 2.0.0

- Architecture upgrade based on adapter.

## 1.1.13

- Downgrade flutter_screenutil to ">=5.5.3+2 <5.6.1"

## 1.1.12

- Update a dependency to the latest release
- Support sdk log

## 1.1.11

- Support view screen sharing stream of web

## 1.1.10

- Update a dependency to the latest release

## 1.1.9

- Update a dependency to the latest release

## 1.1.8

- Update a dependency to the latest release

## 1.1.7

- Update a dependency to the latest release

## 1.1.6

- Fix some bugs
- Update a dependency to the latest release

## 1.1.5

- Fix some bugs

## 1.1.4

- Fix some bugs

## 1.1.3

- Update a dependency to the latest release

## 1.1.2

- Fix some bugs

## 1.1.1

- Fix some bugs

## 1.1.0

- Support chat and notification.

## 1.0.0

- Congratulations!

## 0.0.1

- Upload initial release.