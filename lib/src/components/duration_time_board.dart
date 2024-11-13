// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:zego_uikit/zego_uikit.dart';

// Project imports:
import 'package:zego_uikit_prebuilt_video_conference/src/config.dart';
import 'package:zego_uikit_prebuilt_video_conference/src/events.dart';
import '../core/live_duration_manager.dart';

/// @nodoc
class ZegoVideoConferenceColoredText extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final double? fontSize;
  final double verticalPadding;
  final double horizontalPadding;

  const ZegoVideoConferenceColoredText({
    Key? key,
    required this.text,
    required this.backgroundColor,
    this.fontSize,
    this.verticalPadding = 0.0,
    this.horizontalPadding = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: fontSize ?? 25.zR,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    return Container(
      width: textPainter.width + horizontalPadding * 2,
      height: textPainter.height + verticalPadding * 2,
      margin: EdgeInsets.symmetric(
        vertical: verticalPadding,
        horizontal: horizontalPadding,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              decoration: TextDecoration.none,
              fontSize: fontSize ?? 25.zR,
            ),
          ),
        ),
      ),
    );
  }
}

/// @nodoc
class ZegoVideoConferenceDurationTimeBoard extends StatefulWidget {
  final ZegoVideoConferenceDurationConfig config;
  final ZegoVideoConferenceDurationEvents? events;
  final ZegoVideoConferenceDurationManager manager;

  final double? fontSize;

  const ZegoVideoConferenceDurationTimeBoard({
    Key? key,
    required this.config,
    required this.events,
    required this.manager,
    this.fontSize,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CallDurationTimeBoardState();
}

class _CallDurationTimeBoardState
    extends State<ZegoVideoConferenceDurationTimeBoard> {
  Timer? durationTimer;
  Duration? beginDuration;
  var durationNotifier = ValueNotifier<Duration>(Duration.zero);

  @override
  void initState() {
    super.initState();

    if (widget.config.isVisible) {
      ZegoLoggerService.logInfo(
        'init duration',
        tag: 'video conference',
        subTag: 'prebuilt',
      );

      if (widget.manager.isValid) {
        startDurationTimerByNetworkTime();
      } else {
        widget.manager.notifier.addListener(startDurationTimerByNetworkTime);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();

    durationTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.config.isVisible) {
      return Container();
    }

    return ValueListenableBuilder<Duration>(
      valueListenable: durationNotifier,
      builder: (context, elapsedTime, _) {
        if (!widget.manager.isValid) {
          return Container();
        }

        return elapsedTime.inSeconds <= 0
            ? Container()
            : Stack(
                children: [
                  const Positioned.fill(
                    child: ColoredBox(
                      color: Colors.transparent,
                    ),
                  ),
                  Center(
                    child: ZegoVideoConferenceColoredText(
                      text: durationFormatString(elapsedTime),
                      fontSize: widget.fontSize ?? 25.zR,
                      backgroundColor: Colors.black.withOpacity(0.2),
                      horizontalPadding: 20.zR,
                      verticalPadding: 5.zR,
                    ),
                  ),
                ],
              );
      },
    );
  }

  String durationFormatString(Duration elapsedTime) {
    final hours = elapsedTime.inHours;
    final minutes = elapsedTime.inMinutes.remainder(60);
    final seconds = elapsedTime.inSeconds.remainder(60);

    final minutesFormatString =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    return hours > 0
        ? '${hours.toString().padLeft(2, '0')}:$minutesFormatString'
        : minutesFormatString;
  }

  void startDurationTimerByNetworkTime() {
    if (widget.manager.isValid) {
      final networkTimeNow = ZegoUIKit().getNetworkTime();
      if (null == networkTimeNow.value) {
        ZegoLoggerService.logInfo(
          'network time is null, wait...',
          tag: 'video conference',
          subTag: 'duration time board',
        );

        ZegoUIKit()
            .getNetworkTime()
            .addListener(waitNetworkTimeUpdateForStartDurationTimer);
      } else {
        startDurationTimer(networkTimeNow.value!);
      }
    }
  }

  void waitNetworkTimeUpdateForStartDurationTimer() {
    ZegoUIKit()
        .getNetworkTime()
        .removeListener(waitNetworkTimeUpdateForStartDurationTimer);

    final networkTimeNow = ZegoUIKit().getNetworkTime();
    ZegoLoggerService.logInfo(
      'network time update:$networkTimeNow',
      tag: 'video conference',
      subTag: 'duration time board',
    );

    startDurationTimer(networkTimeNow.value!);
  }

  void startDurationTimer(DateTime networkTimeNow) {
    ZegoLoggerService.logInfo(
      'start duration timer, network time is $networkTimeNow, live begin time is ${widget.manager.notifier.value}',
      tag: 'video conference',
      subTag: 'duration time board',
    );

    beginDuration = networkTimeNow.difference(widget.manager.notifier.value);

    durationTimer?.cancel();
    durationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      durationNotifier.value = beginDuration! + Duration(seconds: timer.tick);
      widget.events?.onUpdated?.call(
        durationNotifier.value,
      );
    });
  }
}
