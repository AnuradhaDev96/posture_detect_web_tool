import 'dart:ui';

import '../../utils/assets.dart';

class PostureResultState {
  final String title;
  final String description;
  final String icon;
  final Size iconSize;
  final Color backgroundColor;

  PostureResultState({
    required this.title,
    required this.description,
    required this.icon,
    required this.iconSize,
    required this.backgroundColor,
  });
}

class RecordingVideo extends PostureResultState {
  RecordingVideo()
      : super(
    title: "Recording",
    description: "Maintain your posture to get results.",
    icon: Assets.recordingIcon,
    iconSize: const Size(50, 50),
    backgroundColor: const Color(0xFF898CA4),
  );
}

class ReceivedGoodPostureResult extends PostureResultState {
  ReceivedGoodPostureResult()
      : super(
    title: "Good Posture",
    description: "Maintain the correct posture.",
    icon: Assets.goodIcon,
    iconSize: const Size(50, 50),
    backgroundColor: const Color(0xFF33B850),
  );
}

class ReceivedBadPostureResult extends PostureResultState {
  ReceivedBadPostureResult()
      : super(
    title: "Bad Posture",
    description: "Bad posture detected. Align your posture correctly.",
    icon: Assets.badIcon,
    iconSize: const Size(50, 50),
    backgroundColor: const Color(0xFFB9637D),
  );
}

class ServerErrorResult extends PostureResultState {
  ServerErrorResult()
      : super(
    title: "Server error",
    description: "Please check whether the prediction server is started and running.",
    icon: Assets.serverIcon,
    iconSize: const Size(50, 50),
    backgroundColor: const Color(0xFFDEAD00),
  );
}

class BreakTakenState extends PostureResultState {
  BreakTakenState()
      : super(
    title: "",
    description: "",
    iconSize: Size.zero,
    icon: "",
    backgroundColor: const Color(0xFFFFFFFF),
  );
}