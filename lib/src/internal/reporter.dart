import 'package:zego_uikit/zego_uikit.dart';

class ZegoVideoConferenceReporter {
  static String eventInit = "conference/init";
  static String eventUninit = "conference/unInit";

  /// Version number of each kit, usually in three segments
  static String eventKeyKitVersion = "conference_version";

  Future<void> report({
    required String event,
    Map<String, Object> params = const {},
  }) async {
    ZegoUIKit().reporter().report(event: event, params: params);
  }

  factory ZegoVideoConferenceReporter() {
    return instance;
  }

  ZegoVideoConferenceReporter._internal();

  static final ZegoVideoConferenceReporter instance =
      ZegoVideoConferenceReporter._internal();
}
