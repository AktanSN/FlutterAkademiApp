import 'package:flutter/material.dart';
import 'package:my_app_v1/view/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'controller/index_controller.dart';

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<IndexController>(
      create: (context) => IndexController(),
      child: const MaterialApp(
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
