part of 'package:zego_uikit_prebuilt_video_conference/src/controller.dart';

mixin ZegoVideoConferenceControllerRoom {
  final _roomController = ZegoVideoConferenceRoomController();

  ZegoVideoConferenceRoomController get room => _roomController;
}

/// Here are the APIs related to room.
class ZegoVideoConferenceRoomController
    with ZegoVideoConferenceControllerRoomPrivate {
  Future<bool> leave(
    BuildContext context, {
    bool showConfirmation = true,
  }) async {
    ZegoLoggerService.logInfo(
      'leave',
      tag: 'video-conference',
      subTag: 'controller',
    );

    final canLeave =
        await private.config?.onLeaveConfirmation?.call(context) ?? false;
    ZegoLoggerService.logInfo(
      'leave, canLeave:$canLeave',
      tag: 'video-conference',
      subTag: 'controller',
    );

    if (canLeave) {
      if (context.mounted) {
        Navigator.of(
          context,
          rootNavigator: private.config?.rootNavigator ?? true,
        ).pop(false);
      } else {
        ZegoLoggerService.logInfo(
          'leave, context not mounted',
          tag: 'video-conference',
          subTag: 'controller',
        );
      }
    }

    return true;
  }

  /// remove user from conference, kick out
  ///
  /// @return Error code, please refer to the error codes document https://docs.zegocloud.com/en/5548.html for details.
  ///
  /// @return A `Future` that representing whether the request was successful.
  Future<bool> removeUser(List<String> userIDs) async {
    ZegoLoggerService.logInfo(
      'remove user:$userIDs',
      tag: 'video-conference',
      subTag: 'controller.room',
    );

    return ZegoUIKit().removeUserFromRoom(userIDs);
  }

  ///  turn on/off user's microphone.
  ///
  ///  If you want to activate the other user's microphone,
  ///  due to privacy permissions, please pay attention to [ZegoUIKitPrebuiltVideoConferenceConfig.onMicrophoneTurnOnByOthersConfirmation].
  ///  After the other user receives this callback, they can confirm through a pop-up box(return true).
  ///  At this time, the microphone will be activated.'
  ///
  /// Example：
  ///
  /// ```dart
  ///
  ///  // eg:
  /// ..onMicrophoneTurnOnByOthersConfirmation =
  ///     (BuildContext context) async {
  ///   const textStyle = TextStyle(
  ///     fontSize: 10,
  ///     color: Colors.white70,
  ///   );
  ///
  ///   return await showDialog(
  ///     context: context,
  ///     barrierDismissible: false,
  ///     builder: (BuildContext context) {
  ///       return AlertDialog(
  ///         backgroundColor: Colors.blue[900]!.withValues(alpha: 0.9),
  ///         title: const Text(
  ///           'You have a request to turn on your microphone',
  ///           style: textStyle,
  ///         ),
  ///         content: const Text(
  ///           'Do you agree to turn on the microphone?',
  ///           style: textStyle,
  ///         ),
  ///         actions: [
  ///           ElevatedButton(
  ///             child: const Text('Cancel', style: textStyle),
  ///             onPressed: () => Navigator.of(context).pop(false),
  ///           ),
  ///           ElevatedButton(
  ///             child: const Text('OK', style: textStyle),
  ///             onPressed: () {
  ///               Navigator.of(context).pop(true);
  ///             },
  ///           ),
  ///         ],
  ///       );
  ///     },
  ///   );
  /// },
  /// ```
  Future<void> muteUser(bool mute, List<String> userIDs) async {
    ZegoLoggerService.logInfo(
      'mute seat, userIDs:$userIDs',
      tag: 'video-conference',
      subTag: 'controller.room',
    );

    for (final userID in userIDs) {
      ZegoUIKit().turnMicrophoneOn(!mute, userID: userID);
    }
  }
}
