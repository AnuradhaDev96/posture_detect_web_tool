import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../themes/app_colors.dart';
import '../../themes/app_text_styles.dart';
import '../../utils/assets.dart';

class DetectMyPosturePage extends StatefulWidget {
  const DetectMyPosturePage({super.key});

  @override
  State<DetectMyPosturePage> createState() => _DetectMyPosturePageState();
}

class _DetectMyPosturePageState extends State<DetectMyPosturePage> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.indigo2,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 52, right: 30),
          child: SvgPicture.asset(Assets.leftArrowIcon, width: 29.64, height: 48),
        ),
        leadingWidth: 105,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Detect my posture",
            textAlign: TextAlign.left,
          ),
        ),
        titleTextStyle: AppTextStyles.pageHeading,
        toolbarHeight: 150,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0, right: 26.0),
            child: SvgPicture.asset(Assets.seatIcon, width: 118,height: 118),
          ),
        ],
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.75,
              height: 503,
              margin: const EdgeInsets.only(left: 136, right: 136, top: 40),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
