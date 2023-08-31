import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_app/models/enums/prediction_result.dart';

import '../../services/predict_posture_service.dart';

class PostureResultState {}

class RecordingVideo extends PostureResultState {}

class ReceivedGoodPostureResult extends PostureResultState {}

class ReceivedBadPostureResult extends PostureResultState {}

class ServerErrorResult extends PostureResultState {}

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