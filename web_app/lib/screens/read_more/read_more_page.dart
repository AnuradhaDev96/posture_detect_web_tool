import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../themes/app_text_styles.dart';
import '../../utils/assets.dart';

class ReadMorePage extends StatelessWidget {
  const ReadMorePage({super.key, required this.image, required this.description});

  final String image;
  final String description;

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
            "Read more",
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
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.5,
                child: Image.asset(Assets.guide1png, fit: BoxFit.fitHeight),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 25.0, bottom: 20.0),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.7,
                  child: Text(
                    description,
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Color(0xFF414D53)),
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
