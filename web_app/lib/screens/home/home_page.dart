import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../themes/app_colors.dart';
import '../../utils/assets.dart';

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
          )
        ],
      ),
    );
  }
}