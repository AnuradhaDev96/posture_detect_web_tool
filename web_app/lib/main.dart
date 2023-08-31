import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


import 'firebase_options.dart';
import 'screens/detect_my_posture/detect_my_posture_page.dart';
import 'screens/home/home_page.dart';
import 'themes/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        scaffoldBackgroundColor: AppColors.indigo2,
      ),
      // home: DetectMyPosturePage(),
      home: HomePage(),
    );
  }
}
