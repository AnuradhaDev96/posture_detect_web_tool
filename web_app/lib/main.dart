import 'package:flutter/material.dart';

import 'screens/detect_my_posture/detect_my_posture_page.dart';

void main() {
  runApp(const PostureDetectingWebApp());
}

class PostureDetectingWebApp extends StatelessWidget {
  const PostureDetectingWebApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Posture Detection',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: DetectMyPosturePage(),
    );
  }
}
