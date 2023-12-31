import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_app/models/enums/prediction_result.dart';

import '../../services/predict_posture_service.dart';
import '../../services/sound_effect_service.dart';
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

  dispose() async {
    if (cameraController.value.isRecordingVideo) {
      await cameraController.stopVideoRecording();
    }

    if (!cameraController.value.isPreviewPaused) {
      await cameraController.pausePreview();
    }

    _fetchResultsTimer?.cancel();
  }

  /// To pause fetching results
  void takeBreak() async {
    if (cameraController.value.isRecordingVideo) {
      await cameraController.stopVideoRecording();
    }
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
        const Duration(seconds: 29),
        (timer) {
          _getPredictionResults();
        },
      );

  /// call API function to get results
  Future<void> _getPredictionResults() async {
    if (cameraController.value.isRecordingVideo) {
      await cameraController.stopVideoRecording().then((shortVideo) async {
        // print("==Stopped recording at: ${DateTime.now()}");
        // print("blob path: ${shortVideo.path}");

        if (shortVideo.path.isNotEmpty) {
          await _postureService.postVideoForPredictionResults(shortVideo.path).then(
                (result) async {
              await _startRecording();

              if (state is! BreakTakenState) {
                switch (result) {
                  case PredictionResult.goodPosture:
                    emit(ReceivedGoodPostureResult());
                    break;
                  case PredictionResult.badPosture:
                    SoundEffectsService().playAssetSoundEffect('audio/bad_posture_alert.wav');
                    emit(ReceivedBadPostureResult());
                    break;
                  case PredictionResult.serverError:
                    emit(ServerErrorResult());
                    break;
                }
              } else {
                emit(BreakTakenState());
              }
            },
          );
        }
      });
    }
  }

  /// Start recording video when,
  /// 1. Page initiates
  /// 3. When resumes camera after break
  /// 2. After API results received
  Future<void> _startRecording() async {
    // print("==Started recording at: ${DateTime.now()}");
    await cameraController.prepareForVideoRecording();
    await cameraController.startVideoRecording();
  }
}
