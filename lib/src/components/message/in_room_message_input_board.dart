// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:zego_uikit/zego_uikit.dart';

/// @nodoc
class ZegoInRoomMessageInputBoard extends ModalRoute<String> {
  final ValueNotifier<String>? valueNotifier;
  final ValueNotifier<bool>? focusNotifier;
  final String placeHolder;
  final bool rootNavigator;
  final String conferenceID;

  ZegoInRoomMessageInputBoard({
    required this.conferenceID,
    required this.rootNavigator,
    this.placeHolder = 'Say something...',
    this.valueNotifier,
    this.focusNotifier,
  }) : super();

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Color get barrierColor => const Color(0x01000000);

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.of(
                context,
                rootNavigator: rootNavigator,
              ).pop(),
              child: Container(color: Colors.transparent),
            ),
          ),
          ZegoInRoomMessageInput(
            roomID: conferenceID,
            placeHolder: placeHolder,
            valueNotifier: valueNotifier,
            focusNotifier: focusNotifier,
            onSubmit: () {
              Navigator.of(
                context,
                rootNavigator: rootNavigator,
              ).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: child,
    );
  }
}
