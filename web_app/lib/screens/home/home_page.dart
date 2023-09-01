import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../themes/app_colors.dart';
import '../../utils/assets.dart';
import '../detect_my_posture/detect_my_posture_page.dart';
import '../posture_guide/posture_guide_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0, bottom: 20.0),
              child: SvgPicture.asset(Assets.seatIcon, width: 200, height: 200),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Stack(
                  children: [
                    Text(
                      'Posture',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 60,
                        letterSpacing: 1.2,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..color = AppColors.indigo1
                          ..strokeWidth = 6,
                      ),
                    ),
                    const Text(
                      'Posture',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w400,
                        fontSize: 60,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Transform(
                  transform: Matrix4.translationValues(0, -28, 0),
                  child: const Text(
                    'DETECTION',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      // letterSpacing: 1.2,
                      fontWeight: FontWeight.w700,
                      fontSize: 60,
                      color: AppColors.indigo1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Align(
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DetectMyPosturePage(),
                  ),
                ),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.5,
                  // height: 210,
                  decoration: BoxDecoration(
                    color: AppColors.indigo1,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.3,
                            child: const Text(
                              'DETECT MY POSTURE',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.32,
                            child: const Text(
                              'Camera will be used to detect your sitting postures',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SvgPicture.asset(
                        Assets.rightArrowFilled,
                        width: 70,
                        height: 70,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Align(
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PostureGuidePage(),
                  ),
                ),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.5,
                  // height: 210,
                  decoration: BoxDecoration(
                    color: AppColors.indigo1,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  margin: const EdgeInsets.only(top: 20.0),
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.3,
                            child: const Text(
                              'POSTURE GUIDE',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SvgPicture.asset(
                        Assets.rightArrowFilled,
                        width: 70,
                        height: 70,
                      ),
                    ],
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
