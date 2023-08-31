import 'dart:async';
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_app/models/enums/prediction_result.dart';

import '../../services/predict_posture_service.dart';
import '../../utils/assets.dart';

class PostureResultState {}

class RecordingVideo extends PostureResultState {
  final String title = "Recording";
  final String description = "Maintain your posture to get results.";
  final String icon = Assets.recordingIcon;
  final Size iconSize = const Size(50, 50);
  final Color backgroundColor = const Color(0xFF898CA4);
}

class ReceivedGoodPostureResult extends PostureResultState {
  final String title = "Good Posture";
  final String description = "Maintain the correct posture.";
  final String icon = Assets.goodIcon;
  final Size iconSize = const Size(50, 50);
  final Color backgroundColor = const Color(0xFF33B850);
}

class ReceivedBadPostureResult extends PostureResultState {
  final String title = "Bad Posture";
  final String description = "Bad posture detected. Align your posture correctly.";
  final String icon = Assets.badIcon;
  final Size iconSize = const Size(50, 50);
  final Color backgroundColor = const Color(0xFFB9637D);
}

class ServerErrorResult extends PostureResultState {
  final String title = "Server error";
  final String description = "Please check whether the prediction server is started and running.";
  final String icon = Assets.serverIcon;
  final Size iconSize = const Size(50, 50);
  final Color backgroundColor = const Color(0xFFDEAD00);
}

class BreakTakenState extends PostureResultState {}

class ReceivePostureResultsController extends Cubit<PostureResultState> {
  ReceivePostureResultsController() : super(RecordingVideo());
  final _postureService = PredictPostureService();

  Timer? _fetchResultsTimer;

  /// This function should be used initially
  Future<void> fetchPredictionResults() async {
    _fetchResultsTimer = _defaultTimer;
  }

  /// To pause fetching results
  void takeBreak() {
    _fetchResultsTimer?.cancel();
    emit(BreakTakenState());
  }

  /// Resume fetching results
  Future<void> resumeFetchingPredictionResults() async {
    emit(RecordingVideo());
    _fetchResultsTimer = _defaultTimer;
  }

  Timer get _defaultTimer => Timer.periodic(const Duration(seconds: 28), (timer) async {
    await _postureService.getPredictionResults().then((result) {
      switch (result) {
        case PredictionResult.goodPosture:
          emit(ReceivedGoodPostureResult());
        case PredictionResult.badPosture:
          emit(ReceivedBadPostureResult());
        case PredictionResult.serverError:
          emit(ServerErrorResult());
      }
    });
  });
}