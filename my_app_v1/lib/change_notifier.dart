import 'package:flutter/material.dart';
import 'package:my_app_v1/view/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'controller/index_controller.dart';

class ChangeNotifier extends StatelessWidget {
  const ChangeNotifier({
    super.key,
  });

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
