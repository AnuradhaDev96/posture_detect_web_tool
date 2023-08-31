import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
  }

  void _pauseCamera() async {
    setState(() {
      widget.cameraController.pausePreview();
      _isPreviewPaused = true;
    });
  }

  void _resumeCamera() async {
    setState(() {
      widget.cameraController.resumePreview();
      _isPreviewPaused = false;
    });
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
                        aspectRatio: widget.cameraController.value.aspectRatio,
                        child: CameraPreview(widget.cameraController),
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
      ],
    );
  }
}
