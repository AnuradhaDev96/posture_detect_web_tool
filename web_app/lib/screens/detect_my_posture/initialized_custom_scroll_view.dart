import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class InitializedCustomScrollView extends StatelessWidget {
  InitializedCustomScrollView({super.key, required this.cameraController});
  final CameraController cameraController;

  final _scrollController = ScrollController();

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
                child: AspectRatio(
                  aspectRatio: cameraController.value.aspectRatio,
                  child: CameraPreview(cameraController),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
