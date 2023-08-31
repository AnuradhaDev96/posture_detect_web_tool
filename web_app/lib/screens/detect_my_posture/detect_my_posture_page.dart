import 'dart:html';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../themes/app_text_styles.dart';
import '../../utils/assets.dart';
import '../widgets/camera_error_widget.dart';
import 'posture_detection_view.dart';

class DetectMyPosturePage extends StatefulWidget {
  const DetectMyPosturePage({super.key});

  @override
  State<DetectMyPosturePage> createState() => _DetectMyPosturePageState();
}

class _DetectMyPosturePageState extends State<DetectMyPosturePage> {
  bool cameraAccess = false;
  List<CameraDescription>? cameras;
  String? error;

  @override
  void initState() {
    super.initState();
    getCameraAccess();
  }

  Future<void> getCameraAccess() async {
    try {
      await window.navigator.mediaDevices!.getUserMedia({'video': true, 'audio': false});
      setState(() {
        cameraAccess = true;
      });
      final cameras = await availableCameras();
      setState(() {
        this.cameras = cameras;
      });
    } on DomException {
      setState(() {
        error = "Cannot detect device camera!";
      });
    } catch (e) {
      setState(() {
        error = "Something went wrong!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: SvgPicture.asset(Assets.leftArrowIcon, width: 25, height: 35)),
        ),
        leadingWidth: 80,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Detect my posture",
            textAlign: TextAlign.left,
          ),
        ),
        titleTextStyle: AppTextStyles.pageHeading,
        toolbarHeight: 100,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, right: 20.0, bottom: 20.0),
            child: SvgPicture.asset(Assets.seatIcon, width: 90, height: 90),
          ),
        ],
      ),
      body: Builder(builder: (context) {
        if (error != null) {
          return CameraErrorWidget(message: '$error');
        }
        if (!cameraAccess) {
          return const CameraErrorWidget(message: 'Camera access not granted yet.');
        }
        if (cameras == null) {
          return const CameraErrorWidget(message: 'Reading cameras');
        }

        return PostureDetectionView(cameras: cameras!);
      }),
    );
  }
}
