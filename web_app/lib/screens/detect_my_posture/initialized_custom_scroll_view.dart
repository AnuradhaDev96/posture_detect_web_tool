import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../blocs/detect_my_posture/recieve_posture_results_controller.dart';
import '../../blocs/states/posture_result_state.dart';
import '../../themes/app_colors.dart';

class InitializedCustomScrollView extends StatefulWidget {
  const InitializedCustomScrollView({super.key, required this.cameraController});

  final CameraController cameraController;

  @override
  State<InitializedCustomScrollView> createState() => _InitializedCustomScrollViewState();
}

class _InitializedCustomScrollViewState extends State<InitializedCustomScrollView> {
  final _scrollController = ScrollController();
  bool _isPreviewPaused = false;

  late final ReceivePostureResultsController _predictionController;

  @override
  void initState() {
    super.initState();
    // _initiateRecording();
    _predictionController = ReceivePostureResultsController(widget.cameraController);
    _predictionController.fetchPredictionResults();
  }

  // Future<void> _initiateRecording() async {
  //   await widget.cameraController.prepareForVideoRecording();
  //   await widget.cameraController.startVideoRecording();
  // }

  void _pauseCamera() async {
    setState(() {
      // widget.cameraController.pausePreview();
      _isPreviewPaused = true;
    });
    _predictionController.takeBreak();
  }

  void _resumeCamera() async {
    setState(() {
      // widget.cameraController.resumePreview();
      _isPreviewPaused = false;
    });
    _predictionController.resumeFetchingPredictionResults();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverToBoxAdapter(
          child: Center(
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.75,
              height: 503,
              margin: const EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: _isPreviewPaused
                    ? GestureDetector(
                        onTap: () => _resumeCamera(),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 200,
                            height: 50,
                            margin: const EdgeInsets.only(top: 12),
                            decoration: BoxDecoration(
                              color: AppColors.indigo1,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: const Center(
                              child: Text(
                                'Resume',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      )
                    : AspectRatio(
                        aspectRatio: _predictionController.cameraController.value.aspectRatio,
                        child: CameraPreview(_predictionController.cameraController),
                      ),
              ),
            ),
          ),
        ),

        // show take a break button when camera preview is not paused
        if (!_isPreviewPaused)
          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () => _pauseCamera(),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 200,
                  height: 50,
                  margin: const EdgeInsets.only(top: 12),
                  decoration: BoxDecoration(
                    color: AppColors.indigo1,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: const Center(
                    child: Text(
                      'Take a Break',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ),

        SliverToBoxAdapter(
          child: BlocProvider<ReceivePostureResultsController>(
            create: (context) => _predictionController,
            child: BlocBuilder<ReceivePostureResultsController, PostureResultState>(
              bloc: _predictionController,
              builder: (context, state) {
                if (state is BreakTakenState) {
                  return const SizedBox.shrink();
                } else {
                  return statusCard(state);
                }
              },
            ),
          ),
        )
      ],
    );
  }

  Widget statusCard(PostureResultState state) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.43,
        height: 230,
        decoration: BoxDecoration(
          color: state.backgroundColor,
          borderRadius: BorderRadius.circular(16.0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 30),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.15,
                  child: Text(
                    state.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.2,
                  child: Text(
                    state.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            SvgPicture.asset(
              state.icon,
              width: 116,
              height: 116,
            )
          ],
        ),
      ),
    );
  }
}
