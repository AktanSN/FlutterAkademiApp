import 'package:flutter/material.dart';
import 'package:my_app_v1/HomePage.dart';
import 'package:my_app_v1/view/screens/home_screen.dart';
import 'package:my_app_v1/view/screens/start_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToFirstPage();
  }

  _navigateToFirstPage() async {
    await Future.delayed(const Duration(milliseconds: 2200), () {});
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          SizedBox(
              width: 500, height: 500, child: Image.asset('assets/logo.png')),
        ]),
      ),
    );
  }
}
