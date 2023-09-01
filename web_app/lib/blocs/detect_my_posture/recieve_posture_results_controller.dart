import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_app/models/enums/prediction_result.dart';

import '../../services/predict_posture_service.dart';
import '../states/posture_result_state.dart';

class ReceivePostureResultsController extends Cubit<PostureResultState> {
  ReceivePostureResultsController(this.cameraController) : super(RecordingVideo());
  final CameraController cameraController;
  final _postureService = PredictPostureService();

  Timer? _fetchResultsTimer;

  /// This function should be used initially
  Future<void> fetchPredictionResults() async {
    if (kDebugMode) print("Initial call at ${DateTime.now()}");

    await _startRecording();

    _fetchResultsTimer = _defaultTimer;
  }

  /// To pause fetching results
  void takeBreak() async {
    await cameraController.stopVideoRecording();
    cameraController.pausePreview();
    _fetchResultsTimer?.cancel();
    emit(BreakTakenState());
  }

  /// Resume fetching results
  Future<void> resumeFetchingPredictionResults() async {
    cameraController.resumePreview();

    await _startRecording();

    emit(RecordingVideo());

    _fetchResultsTimer = _defaultTimer;
  }

  Timer get _defaultTimer => Timer.periodic(
        const Duration(seconds: 12),
        (timer) {
          _getPredictionResults();
        },
      );

  /// call API function to get results
  Future<void> _getPredictionResults() async {
    final shortVideo = await cameraController.stopVideoRecording();

    await _postureService.postVideoForPredictionResults(shortVideo.path).then(
      (result) async {
        await _startRecording();

        if (state is! BreakTakenState) {
          switch (result) {
            case PredictionResult.goodPosture:
              emit(ReceivedGoodPostureResult());
            case PredictionResult.badPosture:
              emit(ReceivedBadPostureResult());
            case PredictionResult.serverError:
              emit(ServerErrorResult());
          }
        } else {
          emit(BreakTakenState());
        }
      },
    );
  }

  /// Start recording video when,
  /// 1. Page initiates
  /// 3. When resumes camera after break
  /// 2. After API results received
  Future<void> _startRecording() async {
    await cameraController.prepareForVideoRecording();
    await cameraController.startVideoRecording();
  }
}
