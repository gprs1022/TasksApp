import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:tasks/routes.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 8), () {
      Get.offNamed(AppRoutes.onboardingScreen);
      // Navigate to Home
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: 200.0,
            height: 200.0,
            child: Lottie.asset(
              'assets/icons/tasksicon.json',
              repeat: true,
              reverse: false,
              animate: true,
            ),
          ),
        ),
      ),
    );
  }
}
