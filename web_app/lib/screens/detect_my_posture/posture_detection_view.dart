import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../widgets/camera_error_widget.dart';
import 'initialized_custom_scroll_view.dart';

class PostureDetectionView extends StatefulWidget {
  const PostureDetectionView({super.key, required this.cameras});

  final List<CameraDescription> cameras;

  @override
  State<PostureDetectionView> createState() => _PostureDetectionViewState();
}

class _PostureDetectionViewState extends State<PostureDetectionView> {
  CameraController? _cameraController;

  String? error;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    setState(() {
      _cameraController = CameraController(
        widget.cameras[0], // Use the appropriate camera (front/back)
        ResolutionPreset.max, // Adjust the resolution preset as needed
        enableAudio: false,
      );
    });

    try {
      await _cameraController?.initialize();
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (error != null) {
      return const CameraErrorWidget(message: 'Failed to initialize camera');
    }
    if (_cameraController == null) {
      return const CameraErrorWidget(message: 'Loading controller...');
    }
    if (!_cameraController!.value.isInitialized) {
      return const CameraErrorWidget(message: 'Initializing camera...');
    }

    return InitializedCustomScrollView(cameraController: _cameraController!);
  }
}
