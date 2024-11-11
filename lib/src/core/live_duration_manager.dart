// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:zego_uikit/zego_uikit.dart';

// Project imports:
import 'package:zego_uikit_prebuilt_video_conference/src/config.dart';

/// @nodoc
class ZegoVideoConferenceDurationManager {
  bool _initialized = false;

  bool get isValid => notifier.value.millisecondsSinceEpoch > 0;

  ZegoVideoConferenceDurationManager() {
    onRoomPropertiesUpdated(ZegoUIKit().getRoomProperties());
    subscription =
        ZegoUIKit().getRoomPropertiesStream().listen(onRoomPropertiesUpdated);
  }

  /// internal variables
  var notifier = ValueNotifier<DateTime>(DateTime(0));
  StreamSubscription<dynamic>? subscription;

  ZegoVideoConferenceDurationConfig? _config;

  Future<void> init({
    ZegoVideoConferenceDurationConfig? config,
  }) async {
    if (_initialized) {
      ZegoLoggerService.logInfo(
        'had already init',
        tag: 'video-conference',
        subTag: 'seat manager',
      );

      return;
    }

    _initialized = true;
    _config = config;

    ZegoLoggerService.logInfo(
      'init',
      tag: 'video-conference',
      subTag: 'live duration manager',
    );

    setRoomPropertyByHost();
  }

  Future<void> uninit() async {
    if (!_initialized) {
      ZegoLoggerService.logInfo(
        'not init before',
        tag: 'video-conference',
        subTag: 'seat manager',
      );

      return;
    }

    _initialized = false;
    _config = null;

    ZegoLoggerService.logInfo(
      'uninit',
      tag: 'video-conference',
      subTag: 'live duration manager',
    );
    subscription?.cancel();
  }

  void onRoomPropertiesUpdated(Map<String, RoomProperty> updatedProperties) {
    final roomProperties = ZegoUIKit().getRoomProperties();
    ZegoLoggerService.logInfo(
      'onRoomPropertiesUpdated roomProperties:$roomProperties, updatedProperties:$updatedProperties',
      tag: 'video-conference',
      subTag: 'live duration manager',
    );

    if (roomProperties.containsKey(RoomPropertyKey.liveDuration.text)) {
      final propertyTimestamp =
          roomProperties[RoomPropertyKey.liveDuration.text]!.value;

      final serverDateTime = DateTime.fromMillisecondsSinceEpoch(
          int.tryParse(propertyTimestamp) ?? 0);

      ZegoLoggerService.logInfo(
        'live duration value is exist:${notifier.value}',
        tag: 'video-conference',
        subTag: 'live duration manager',
      );

      notifier.value = serverDateTime;
    }
  }

  void setRoomPropertyByHost() {
    if (!(_config?.canSync ?? false)) {
      ZegoLoggerService.logInfo(
        'try set value, but can not sync in [ZegoVideoConferenceDurationConfig]',
        tag: 'video-conference',
        subTag: 'live duration manager',
      );
      return;
    }

    subscription?.cancel();

    final networkTimeNow = ZegoUIKit().getNetworkTime();
    if (null == networkTimeNow.value) {
      ZegoLoggerService.logInfo(
        'network time is null, wait..',
        tag: 'video-conference',
        subTag: 'live duration manager',
      );

      ZegoUIKit()
          .getNetworkTime()
          .addListener(waitNetworkTimeUpdatedForSetProperty);
    } else {
      setPropertyByNetworkTime(networkTimeNow.value!);
    }
  }

  void waitNetworkTimeUpdatedForSetProperty() {
    ZegoUIKit()
        .getNetworkTime()
        .removeListener(waitNetworkTimeUpdatedForSetProperty);

    final networkTimeNow = ZegoUIKit().getNetworkTime();
    ZegoLoggerService.logInfo(
      'network time update:$networkTimeNow',
      tag: 'video-conference',
      subTag: 'live duration manager',
    );

    setPropertyByNetworkTime(networkTimeNow.value!);
  }

  void setPropertyByNetworkTime(DateTime networkTimeNow) {
    notifier.value = networkTimeNow;

    ZegoLoggerService.logInfo(
      'host set value:${notifier.value}',
      tag: 'video-conference',
      subTag: 'live duration manager',
    );

    ZegoUIKit().setRoomProperty(
      RoomPropertyKey.liveDuration.text,
      networkTimeNow.millisecondsSinceEpoch.toString(),
    );
  }
}
