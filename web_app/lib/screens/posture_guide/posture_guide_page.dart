import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../themes/app_colors.dart';
import '../../themes/app_text_styles.dart';
import '../../utils/assets.dart';

class PostureGuidePage extends StatelessWidget {
  const PostureGuidePage({super.key});

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
            "Posture guide",
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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: MediaQuery.sizeOf(context).width * 0.5,
                decoration: BoxDecoration(
                  color: AppColors.indigo1,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                margin: const EdgeInsets.only(top: 20.0),
                padding: const EdgeInsets.only(left: 25.0, top: 20, bottom: 20),
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    child: Image.asset(Assets.guide1png, fit: BoxFit.fitHeight),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: MediaQuery.sizeOf(context).width * 0.5,
                decoration: BoxDecoration(
                  color: AppColors.indigo1,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                margin: const EdgeInsets.only(top: 20.0),
                padding: const EdgeInsets.only(left: 25.0, top: 20, bottom: 20),
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    child: Image.asset(Assets.guide2png, fit: BoxFit.fitHeight),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: MediaQuery.sizeOf(context).width * 0.5,
                decoration: BoxDecoration(
                  color: AppColors.indigo1,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                margin: const EdgeInsets.only(top: 20.0, bottom: 30.0),
                padding: const EdgeInsets.only(left: 25.0, top: 20, bottom: 20),
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    child: Image.asset(Assets.guide3png, fit: BoxFit.fitHeight),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
